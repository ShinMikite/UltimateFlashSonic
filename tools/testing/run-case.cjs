// Run a scripted browser playtest with a locally installed Ruffle and Playwright.
const fs = require('node:fs');
const path = require('node:path');
const http = require('node:http');
const crypto = require('node:crypto');

(async () => {
  const [dependencies, movie, scenario, output] = process.argv.slice(2);
  if (!output) throw new Error('Usage: node tools/runtime-test.cjs DEPENDENCIES SWF SCENARIO_JSON OUTPUT');
  const { chromium } = require(path.resolve(dependencies, 'node_modules/playwright'));
  const ruffle = path.resolve(dependencies, 'node_modules/@ruffle-rs/ruffle');
  const swf = fs.readFileSync(movie);
  const config = JSON.parse(fs.readFileSync(scenario, 'utf8')); const steps = config.steps;
  fs.mkdirSync(output, { recursive: true });
  const server = http.createServer((req, res) => {
    const url = new URL(req.url, 'http://localhost');
    if (url.pathname === '/') {
      res.setHeader('Content-Type', 'text/html');
      res.end(`<body><style>body{margin:0;background:#222}ruffle-player{width:700px;height:500px;display:block}</style>
        <script src="/ruffle/ruffle.js"></script><script>
        const p=window.RufflePlayer.newest().createPlayer();document.body.append(p);
        window.traces=[];setInterval(()=>{p.ruffle().traceObserver=m=>{window.traces.push(m);console.log("TRACE "+m);};},20);p.ruffle().traceObserver=m=>{window.traces.push(m);console.log("TRACE "+m);};fetch('/game.swf').then(r=>r.arrayBuffer()).then(data=>p.ruffle().load({parameters:${JSON.stringify(config.parameters)},data:new Uint8Array(data),autoplay:'on',unmuteOverlay:'hidden',splashScreen:false,allowNetworking:'none'})).then(()=>{p.ruffle().traceObserver=m=>{window.traces.push(m);console.log("TRACE "+m);};});
        window.player=p;</script>`);
    } else if (url.pathname === '/favicon.ico') { res.writeHead(204); res.end();
    } else if (url.pathname === '/game.swf') {
      res.setHeader('Content-Type', 'application/x-shockwave-flash'); res.end(swf);
    } else if (url.pathname.startsWith('/ruffle/')) {
      const file = path.resolve(ruffle, '.' + url.pathname.slice(7));
      if (!file.startsWith(ruffle + path.sep) || !fs.existsSync(file)) { res.writeHead(404); res.end(); return; }
      res.setHeader('Content-Type', file.endsWith('.wasm') ? 'application/wasm' : 'text/javascript');
      fs.createReadStream(file).pipe(res);
    } else { res.writeHead(404); res.end(); }
  });
  await new Promise(resolve => server.listen(0, '127.0.0.1', resolve));
  const browser = await chromium.launch({ headless: true, channel: 'chrome', args: ['--autoplay-policy=no-user-gesture-required'] });
  const page = await browser.newPage({ viewport: { width: 700, height: 500 } });
  const errors = []; const messages=[]; const startupRetries=[];
  page.on('pageerror', error => errors.push(error.message));
  page.on('console', message => { messages.push(message.text()); if(message.text().startsWith("TRACE ")) console.log(message.text()); if (message.type() === 'error') errors.push(message.text()); });
  try {
    await page.goto(`http://127.0.0.1:${server.address().port}`);
    for (const step of steps) {
      if (step.untilDone) {
        await page.waitForTimeout(1000);
        await page.evaluate(()=>{window.player.ruffle().resume();window.player.focus();});
        for(let attempt=0;attempt<3;attempt++) {
          try {
            await page.waitForFunction(()=>window.traces && window.traces.some(t=>t.startsWith('READY|') || t.startsWith('PASSWORD|')), {}, {timeout:15000,polling:20});
            break;
          } catch(error) {
            const trace=await page.evaluate(()=>window.traces);
            startupRetries.push({attempt:attempt+1,traces:trace});
            await page.screenshot({path:path.join(output,'startup-'+(attempt+1)+'.png')});
            if(attempt==2 || errors.length) throw error;
            console.log('Retrying fixture startup before gameplay checks');
            await page.reload();
          }
        }
        await page.keyboard.down('Space');
        await page.waitForFunction(()=>window.traces && window.traces.includes('DONE'), { }, {timeout:90000,polling:20});
        await page.keyboard.up('Space');
        await page.waitForTimeout(400);
      }
      if (step.wait) await page.waitForTimeout(step.wait);
      if (step.click) await page.mouse.click(...step.click, { delay: 120 });
      if (step.down) await page.keyboard.down(step.down);
      if (step.up) await page.keyboard.up(step.up);
      if (step.press) await page.keyboard.press(step.press, { delay: 120 });
      if (step.shot) await page.screenshot({ path: path.join(output, step.shot + '.png') });
    }
    const report = { movie: path.basename(movie), sha256: crypto.createHash('sha256').update(swf).digest('hex'),
      runtime: JSON.parse(fs.readFileSync(path.join(ruffle, 'package.json'))).version,
      browser: browser.version(), parameters: config.parameters, steps, errors, startupRetries, messages, traces: await page.evaluate(()=>window.traces) };
    fs.writeFileSync(path.join(output, 'runtime.json'), JSON.stringify(report, null, 2) + '\n');
    console.log(JSON.stringify(report));
    if (errors.length || report.traces.some(t=>t.startsWith('FAIL|'))) process.exitCode = 1;
  } finally { await browser.close(); server.close(); }
})().catch(error => { console.error(error); process.exitCode = 1; });
