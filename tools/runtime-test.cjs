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
  const steps = JSON.parse(fs.readFileSync(scenario, 'utf8'));
  fs.mkdirSync(output, { recursive: true });
  const server = http.createServer((req, res) => {
    const url = new URL(req.url, 'http://localhost');
    if (url.pathname === '/') {
      res.setHeader('Content-Type', 'text/html');
      res.end(`<body><style>body{margin:0;background:#222}ruffle-player{width:700px;height:500px;display:block}</style>
        <script src="/ruffle/ruffle.js"></script><script>
        const p=window.RufflePlayer.newest().createPlayer();document.body.append(p);
        p.ruffle().load({url:'/game.swf',autoplay:'on',unmuteOverlay:'hidden',splashScreen:false,allowNetworking:'none'});
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
  const errors = [];
  page.on('pageerror', error => errors.push(error.message));
  page.on('console', message => { if (message.type() === 'error') errors.push(message.text()); });
  try {
    await page.goto(`http://127.0.0.1:${server.address().port}`);
    for (const step of steps) {
      if (step.wait) await page.waitForTimeout(step.wait);
      if (step.click) await page.mouse.click(...step.click, { delay: 120 });
      if (step.down) await page.keyboard.down(step.down);
      if (step.up) await page.keyboard.up(step.up);
      if (step.press) await page.keyboard.press(step.press, { delay: 120 });
      if (step.shot) await page.screenshot({ path: path.join(output, step.shot + '.png') });
    }
    const report = { movie: path.basename(movie), sha256: crypto.createHash('sha256').update(swf).digest('hex'),
      runtime: JSON.parse(fs.readFileSync(path.join(ruffle, 'package.json'))).version,
      browser: browser.version(), steps, errors };
    fs.writeFileSync(path.join(output, 'runtime.json'), JSON.stringify(report, null, 2) + '\n');
    console.log(JSON.stringify(report));
    if (errors.length) process.exitCode = 1;
  } finally { await browser.close(); server.close(); }
})().catch(error => { console.error(error); process.exitCode = 1; });
