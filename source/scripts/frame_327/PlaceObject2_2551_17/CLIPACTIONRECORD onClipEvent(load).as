onClipEvent(load){
   function setobject(type, x, y, xspeed, yspeed)
   {
      a = _root.objcount;
      _root.objcount += 1;
      if(_root.objtotal < _root.objcount)
      {
         _root.objcount = 1;
      }
      _root.attachMovie(type,"obj" add a,a + 45);
      _root["obj" add a]._x = x;
      _root["obj" add a]._y = y;
      _root["obj" add a].o.y = yspeed;
      _root["obj" add a].o.x = xspeed;
   }
   function setlevel()
   {
      count = 0;
      var a = 1;
      while(9 >= a)
      {
         var a2 = 1;
         while(_root.objects >= a2)
         {
            if(_root.levelo["p" add a]["o" add a2].save == "on")
            {
               lvlo["x" add (lx + (a - count * 3)) add "y" add (ly + count) add "xpos" add a2] = _root.levelo["p" add a]["o" add a2]._x;
               if(_root.levelo["p" add a]["o" add a2].save2 == "on")
               {
                  lvlo["x" add (lx + (a - count * 3)) add "y" add (ly + count) add "yposS" add a2] = _root.levelo["p" add a]["o" add a2]._y;
               }
               else
               {
                  lvlo["x" add (lx + (a - count * 3)) add "y" add (ly + count) add "ypos" add a2] = _root.levelo["p" add a]["o" add a2]._y;
               }
               lvlo["x" add (lx + (a - count * 3)) add "y" add (ly + count) add "xscale" add a2] = _root.levelo["p" add a]["o" add a2]._xscale;
               lvlo["x" add (lx + (a - count * 3)) add "y" add (ly + count) add "e" add a2] = _root.levelo["p" add a]["o" add a2].energy;
            }
            a2++;
         }
         if(a == 3 || a == 6)
         {
            count += 1;
         }
         a++;
      }
      count = 0;
      var a = 1;
      while(9 >= a)
      {
         if(0 >= this.lvl["x" add (x + (a - count * 3)) add "y" add (y + count)])
         {
            this["p" add a].gotoAndStop(2);
         }
         else
         {
            this["p" add a].gotoAndStop(this.lvl["x" add (x + (a - count * 3)) add "y" add (y + count)]);
         }
         if(0 >= this.lvl2["x" add (x + (a - count * 3)) add "y" add (y + count)])
         {
            if(0 >= this.lvl["x" add (x + (a - count * 3)) add "y" add (y + count)])
            {
               _root.Level2["p" add a].gotoAndStop(2);
            }
            else
            {
               _root.Level2["p" add a].gotoAndStop(this.lvl["x" add (x + (a - count * 3)) add "y" add (y + count)]);
            }
         }
         else
         {
            _root.Level2["p" add a].gotoAndStop(this.lvl2["x" add (x + (a - count * 3)) add "y" add (y + count)]);
         }
         var a2 = 1;
         while(_root.objects >= a2)
         {
            _root.levelo["p" add a]["o" add a2].removeMovieClip();
            _root.levelo2["p" add a]["o" add a2].removeMovieClip();
            if(0 < this.lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "o" add a2])
            {
               obid = this.lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "o" add a2];
               if(lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "o" add a2] == 11 || lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "o" add a2] == 12 || lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "o" add a2] == 2 || lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "o" add a2] == 17)
               {
                  _root.levelo2["p" add a].attachMovie("object" add obid,"o" add a2,a2);
                  _root.levelo2["p" add a]["o" add a2]._x = lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "xpos" add a2];
                  _root.levelo2["p" add a]["o" add a2]._y = lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "ypos" add a2];
                  _root.levelo2["p" add a]["o" add a2]._yscale = lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "yscale" add a2];
                  _root.levelo2["p" add a]["o" add a2].energy = lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "e" add a2];
                  _root.levelo2["p" add a]["o" add a2].object = a;
               }
               else
               {
                  _root.levelo["p" add a].attachMovie("object" add obid,"o" add a2,a2);
                  _root.levelo["p" add a]["o" add a2]._x = lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "xpos" add a2];
                  _root.levelo["p" add a]["o" add a2]._y = lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "ypos" add a2];
                  _root.levelo["p" add a]["o" add a2]._yscale = lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "yscale" add a2];
                  _root.levelo["p" add a]["o" add a2].energy = lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "e" add a2];
                  _root.levelo["p" add a]["o" add a2].object = a;
                  _root.levelo["p" add a]["o" add a2].objectn = a2;
                  _root.levelo["p" add a]["o" add a2].lvlo = "x" add (x + (a - count * 3)) add "y" add (y + count);
                  if(0 < lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "xscale" add a2])
                  {
                     _root.levelo["p" add a]["o" add a2]._xscale = lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "xscale" add a2];
                  }
                  if(0 < lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "yscale" add a2])
                  {
                     _root.levelo["p" add a]["o" add a2]._yscale = lvlo["x" add (x + (a - count * 3)) add "y" add (y + count) add "yscale" add a2];
                  }
               }
            }
            a2++;
         }
         if(a == 3 || a == 6)
         {
            count += 1;
         }
         a++;
      }
   }
   if(_root.boss == "on")
   {
      _root.attachMovie(["boss" add _root.czone],"bossobj",59);
      _root.bossobj._x = 265;
      _root.bossobj._y = 60;
   }
   _root.objtotal = 10;
   _root.objcount = 1;
   _root.objects = 3;
   this.swapDepths(10);
   _root.Level2.swapDepths(5);
   _root.Levelo2.swapDepths(15);
   _root.Levelo.swapDepths(6);
   CameraSpeed = 6;
   x = 1;
   y = 1;
   mw = 350;
   mh = 250;
   pw = 180;
   pwh = 90;
   count = 0;
   this.p1.swapDepths(-1);
   this.attachMovie("level-" add _root.czone,"p1",1);
   this.p1._x = 0;
   this.p1._y = 0;
   var forvar = 2;
   while(9 >= forvar)
   {
      duplicateMovieClip("p1","p" add forvar,16384 + (- forvar));
      this["p" add forvar]._x = this.p1._x + (forvar - 1) * pw - count * (3 * pw);
      this["p" add forvar]._y = this.p1._y + count * pw;
      if(forvar == 3 || forvar == 6)
      {
         count += 1;
      }
      forvar++;
   }
   w = 175;
   h = 125;
   if(_root.boss == "on")
   {
      _root.attachMovie("zone-boss","loadlevel",51);
   }
   else
   {
      _root.attachMovie(["zone" add _root.czone add "-act" add _root.cact],"loadlevel",51);
   }
   setlevel();
}
