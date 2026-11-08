// Deterministic fixtures for coverage tests; never part of the release build.
_root.testTick = 0;
_root.testPhase = "start";
_root.testStep = function() {
   _root.testTick++;
   var t = _root.testTick;
   if(t==1) trace("BOOT|game|"+_root._currentframe+"|"+_root.czone+"|"+_root.chara);
   if(t % 300 == 0) trace("STATE|"+_root.testPhase+"|"+_root.pause+"|"+_root.bossobj.egg._currentframe+"|"+_root.testBoss._currentframe+"|"+typeof(_root.leveloutro)+"|"+_root._currentframe);
   if(t == 110) {
      trace("READY|" + _root.chara + "|" + _root.czone + "|" + _root.cact + "|" + _root.Level.maxY);
      if(_root.testKind == "death") {
         _root.Sonic1.dead="on";_root.Sonic1._y=400;
         _root.testPhase="death";
      } else if(_root.testKind == "cheat") {
         _root.Sonic1.g="on";_root.Sonic1.x=15;_root.Sonic1.j="off";_root.Sonic1.roll="off";
         _root.Sonic1.animations();
         trace("EFFECT|"+_root.testCheat+"|"+_root.Sonic1.sonic._currentframe+"|"+typeof(_root.cheese)+"|"+_root.Sonic1.cdepth+"|"+_root.cheese.cheese._xscale+"|"+_root.Sonic1.gravity+"|"+_root.Sonic1.accel+"|"+_root.pausescreen._currentframe);
         for(var k in _root.cheese) if(typeof(_root.cheese[k]) == "movieclip") trace("COMPANION|"+k+"|"+_root.cheese[k]._xscale);
         trace("DONE");_root.testPhase="done";
      } else if(_root.testKind == "unlocks") {
         trace("LOCKED|" + _root.unlock[1] + "|" + _root.unlock[2] + "|" + _root.unlock[3] + "|" + _root.getpasswd());
         var names = ["sonic","tails","knuckles","cream","amy","shadow"];
         for(var i=0;i<6;i++) {
            _root.save[names[i]] = "31";
            _root.setcheats();
            trace("UNLOCK|" + names[i] + "|" + _root.unlock[1] + "|" + _root.unlock[2] + "|" + _root.unlock[3] + "|" + _root.cheat[1] + "|" + _root.cheat[2] + "|" + _root.cheat[3] + "|" + _root.cheat[4] + "|" + _root.cheat[5] + "|" + _root.getpasswd());
         }
         trace("DONE");
         _root.testPhase="done";
      } else if(_root.testKind == "boss") {
         for(var n in _root.bossobj) {
            if(typeof(_root.bossobj[n].energy) == "number") _root.testBoss = _root.bossobj[n];
         }
         _root.testEnergy = _root.testBoss.energy;
         trace("BOSS|" + _root.testEnergy);
         _root.testPhase="boss";
      } else {
         _root.testTiles=[];
         _root.testTileSum=0;
         _root.testIndex=0;
         for(var key in _root.Level.lvl) _root.testTiles.push(key);
         for(var key in _root.Level.lvlo) {
            if(_root.Level.lvlo[key] == 13 && key.charAt(key.length-2) == "o") _root.testSign=key;
         }
         _root.pause=1;
         _root.testPhase="tiles";
      }
   }
   if(_root.testPhase == "tiles") {
      if(_root.testIndex < _root.testTiles.length) {
         var key=_root.testTiles[_root.testIndex];
         var xy=key.substr(1).split("y");
         _root.Level.x=Number(xy[0])-1;
         _root.Level.y=Number(xy[1]);
         _root.Level.setlevel();
         var expected=Number(_root.Level.lvl[key]);
         if(expected <= 0) expected=2;
         if(_root.Level.p1._currentframe != expected) trace("FAIL|tile|" + key + "|" + expected + "|" + _root.Level.p1._currentframe);
         _root.testTileSum+=expected;
         _root.testIndex++;
      } else {
         trace("TILES|" + _root.testIndex + "|" + _root.testTileSum);
         var parts=_root.testSign.split("o");
         var xy=parts[0].substr(1).split("y");
         _root.Level.x=Number(xy[0])-1;
         _root.Level.y=Number(xy[1]);
         _root.Level._x=0; _root.Level._y=0;
         _root.Level.setlevel();
         _root.testObject=_root.levelo.p1["o"+parts[1]];
         _root.testPhase="sign";
         _root.testDeadline=t+80;
      }
   } else if(_root.testPhase == "sign") {
      var point={x:0,y:0};
      _root.testObject.localToGlobal(point);
      _root.h._x=point.x; _root.h._y=point.y;
      _root.h._xscale=2000; _root.h._yscale=2000;
      if(_root.Sonic1.fin == "on") {
         trace("FINISH_SIGN|on");
         _root.testPhase="exit";
         _root.h._xscale=100; _root.h._yscale=100;
      } else if(t > _root.testDeadline) {
         trace("FAIL|finish_sign|"+_root.testSign);trace("DONE");_root.testPhase="done";
      }
   } else if(_root.testPhase == "exit") {
      _root.Level.x=Math.floor(_root.Level.maxX/180)+2;
      _root.Sonic1._x=400;
      _root.Sonic1._y=100;
      _root.pause=0;
      if(typeof(_root.leveloutro) == "movieclip") { trace("OUTRO"); _root.testPhase="outro"; }
   } else if(_root.testPhase == "boss") {
      if(t > 180 && _root.bossstat != "defeated") {
         _root.Sonic1._x=200; _root.Sonic1._y=125;
         _root.Sonic1.j="on"; _root.Sonic1.fly="off";
         var bounds=_root.bossobj.egg.getBounds(_root);
         var point={x:(bounds.xMin+bounds.xMax)/2,y:(bounds.yMin+bounds.yMax)/2};
         _root.Sonic1.globalToLocal(point);
         _root.Sonic1.hitb._x=point.x; _root.Sonic1.hitb._y=point.y;
         _root.Sonic1.hitb._xscale=200; _root.Sonic1.hitb._yscale=200;
         _root.rings=99;
      }
      if(_root.testBoss.energy != _root.testEnergy) {
         _root.testEnergy=_root.testBoss.energy;
         trace("HIT|"+_root.testEnergy);
      }
      if(_root.bossstat == "defeated") {
         trace("DEFEATED");_root.testPhase="boss-outro";
         _root.Sonic1.hitb._xscale=100; _root.Sonic1.hitb._yscale=100;
         _root.Sonic1.hitb._x=0; _root.Sonic1.hitb._y=0;
      }
   } else if(_root.testPhase == "boss-outro") {
      if(typeof(_root.leveloutro) == "movieclip") { trace("OUTRO"); _root.testPhase="outro"; }
   }
   if(_root.testPhase == "death" && typeof(_root.gameover) == "movieclip") { trace("GAMEOVER");_root.testPhase="game-over"; }
   if(_root.testPhase == "outro") { _root.pause=2; }
   if(t == 1500) { trace("FAIL|timeout|"+_root.testPhase);trace("DONE"); }
};
_root.chara=_root.testCharacter;
_root.czone=Number(_root.testZone);
_root.cact=Number(_root.testAct);
_root.boss=_root.testKind == "boss" ? "on" : "off";
_root.mode=_root.testMode == "timetrial" ? "timetrial" : "main";
_root.lives=_root.testLives == "0" ? 0 : 3;
if(_root.testPriorCharacters.length > 0) {
   var completed=_root.testPriorCharacters.split(",");
   for(var i=0;i<completed.length;i++) _root.save[completed[i]]="31";
   _root.setcheats();
}
if(_root.testKind == "cheat") {
   if(Number(_root.testCheat) < 6) _root.cheat[Number(_root.testCheat)]=2;
   else _root.unlock[3]=1;
}
_root.testMenuStep=function() {
   if(_root.testKind != "menu") {
      _root.testMenuTick++;
      if(_root.testMenuTick==1 || _root.testMenuTick==30) trace("BOOT|menu|"+_root.testMenuTick+"|"+_root._currentframe);
      if(_root.testMenuTick == 30) {
         _root.chara=_root.testCharacter;
         _root.lives=_root.testLives == "0" ? 0 : 3;
         _root.czone=Number(_root.testZone);_root.cact=Number(_root.testAct);
         _root.boss=_root.testKind == "boss" ? "on" : "off";
         _root.mode=_root.testMode == "timetrial" ? "timetrial" : "main";
         _root.gotoAndStop(327);
      }
      return;
   }
   _root.testTick++;
   var t=_root.testTick;
   if(t==80) { _root.m.current="setpasswd";_root.m.setbuttons(); }
   if(t==85) {
      _root.m.b2.t="595313131313131";_root.m.b4.d="on";_root.m.setpasswdf();
      trace("PASSWORD|"+_root.m.b2.t+"|"+_root.getpasswd()+"|"+_root.unlock[1]+"|"+_root.unlock[2]+"|"+_root.unlock[3]);
   }
   if(t==90) {
      _root.m.b2.t="000313131313131";_root.m.b4.d="on";_root.m.setpasswdf();
      trace("INVALID|"+_root.m.b2.t+"|"+_root.getpasswd());
   }
   if(t==95) {
      _root.m.b2.t="dennis_gid";_root.m.b4.d="on";_root.m.setpasswdf();
      trace("EASTER_EGG|"+typeof(_root.easteregg));
      _root.easteregg.removeMovieClip();
      _root.m.current="chara";_root.m.setbuttons();
      trace("CHARACTERS|"+_root.m.b5.t+"|"+_root.m.b6.t);
   }
   if(t==100) {
      _root.m.current="cheats";_root.m.setbuttons();
      for(var i=1;i<=5;i++) {
         _root.m["b"+(i+1)].d="on";_root.m.cheatsf();
         trace("TOGGLE|"+i+"|"+_root.cheat[i]);
         _root.m["b"+(i+1)].d="on";_root.m.cheatsf();
         trace("TOGGLE_OFF|"+i+"|"+_root.cheat[i]);
      }
      trace("DONE");
   }
};
_root.testMenuTick=0;
_root.gotoAndStop(291);

trace("BOOT|init|"+_root.testKind+"|"+_root.testZone);
