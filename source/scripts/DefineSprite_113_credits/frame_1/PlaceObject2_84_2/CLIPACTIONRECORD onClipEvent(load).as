onClipEvent(load){
   this._alpha = 0;
   if(this._name == "t1")
   {
      this.swapDepths(50);
      z = 1;
      credits = new Array();
      credits[z] = "ultimate flash sonic";
      credits[z add "-type"] = 2;
      z += 1;
      z += 1;
      credits[z] = "created by";
      credits[z add "-type"] = 2;
      z += 1;
      credits[z] = "menace.ch";
      z += 1;
      z += 1;
      credits[z] = "original game by";
      credits[z add "-type"] = 2;
      z += 1;
      credits[z] = "SONIC-TEAM";
      z += 1;
      credits[z] = "www.sonicteam.com";
      z += 1;
      z += 1;
      z += 1;
      credits[z] = "programmer";
      credits[z add "-type"] = 2;
      z += 1;
      credits[z] = "DENNIS_GID";
      z += 1;
      z += 1;
      z += 1;
      credits[z] = "CHARACTER SPRITES";
      credits[z add "-type"] = 2;
      z += 1;
      credits[z] = "created by";
      credits[z add "-type"] = 2;
      z += 1;
      credits[z] = "SONIC-TEAM";
      z += 1;
      credits[z] = "ripped by";
      credits[z add "-type"] = 2;
      z += 1;
      credits[z] = "DanielSidney";
      z += 1;
      z += 1;
      z += 1;
      credits[z] = "ENDING SPRITES";
      credits[z add "-type"] = 2;
      z += 1;
      credits[z] = "created by";
      credits[z add "-type"] = 2;
      z += 1;
      credits[z] = "SONIC-TEAM";
      z += 1;
      credits[z] = "ripped by";
      credits[z add "-type"] = 2;
      z += 1;
      credits[z] = "Dioxas";
      z += 1;
      credits[z] = "www.chez.com/dsx1980";
      z += 1;
      z += 1;
      z += 1;
      credits[z] = "music / sound FX";
      credits[z add "-type"] = 2;
      z += 1;
      credits[z] = "Sonic-Team";
      z += 1;
      z += 1;
      z += 1;
      credits[z] = "leveldesign";
      credits[z add "-type"] = 2;
      z += 1;
      credits[z] = "DENNIS_GID";
      z += 1;
      z += 1;
      z += 1;
      credits[z] = "Sonic-Team rules!";
      credits[z add "-type"] = 2;
      z += 1;
      credits[z] = "NOW GO AND BUY";
      z += 1;
      credits[z] = "SONIC ADVANCE 2!!!";
      z += 1;
      credits[z] = "THE BEST GAME EVER";
      c = 1;
      speed = 0.5;
      total = 10;
      abst = 20;
      top = 40;
      bot = 235;
      totalc = z + total;
      var a = 1;
      while(total >= a)
      {
         if(a != 1)
         {
            duplicateMovieClip(this,"t" add a,16384 + a);
         }
         _root[getProperty("../", _name)]["t" add a].t = credits[c];
         if(credits[c add "-type"] == 2)
         {
            _root[getProperty("../", _name)]["t" add a].gotoAndStop(2);
         }
         else
         {
            _root[getProperty("../", _name)]["t" add a].gotoAndStop(1);
         }
         _root[getProperty("../", _name)]["t" add a].t = credits[c];
         c += 1;
         _root[getProperty("../", _name)]["t" add a]._y = this._y + (a - 1) * abst;
         a++;
      }
      if(_root.chara == "amy")
      {
         _root.music.music("rose",999999);
      }
      else
      {
         _root.music.music("credits",999999);
      }
   }
}
