onClipEvent(enterFrame){
   if(fin != "on" && 1 >= _root.pause && dead != "on")
   {
      if(Key.isDown(Key.ENTER))
      {
         if(pausedown == "off")
         {
            if(_root.pause == 1)
            {
               _root.pause = 0;
            }
            else
            {
               _root.pause = 1;
            }
         }
         pausedown = "on";
      }
      else
      {
         pausedown = "off";
      }
   }
   if(_root.pause != 0 || dead == "on")
   {
      if(dead == "on")
      {
         _root.pause = 2;
         y -= 1;
         this._y -= y;
         this._rotation = 0;
         this.sonic.gotoAndStop("dead");
         if(_root.level.mh + 50 < this._y)
         {
            if(0 < _root.lives)
            {
               _root.restart = "on";
               if(_root.mode == "main")
               {
                  _root.lives -= 1;
               }
               _root.gotoAndStop("fin");
            }
            else if(_root.quit != "on")
            {
               _root.attachMovie("gameover","gameover",60);
               _root.quit = "on";
            }
         }
      }
   }
   else
   {
      if(hit != "on")
      {
         if(swing != "on")
         {
            if(fin == "on")
            {
               if(x < xmaxa && g == "on")
               {
                  x += accel;
                  this._xscale = 100;
               }
               setgravity();
            }
            else if(g == "on")
            {
               control_g();
            }
            else
            {
               setgravity();
               control_a();
            }
         }
      }
      else
      {
         rot = 0;
         rot2 = 0;
         setgravity();
      }
      if(0 < x)
      {
         t = x + 1;
      }
      else
      {
         t = - x + 1;
      }
      xplus = t + 5;
      hwall = 55 - xplus;
      hwall2 = 45 - xplus;
      _root.h3._y = this._y + m * Math.sin(0.017453292519943295 * (rot - 90));
      _root.h3._x = this._x + m * Math.cos(0.017453292519943295 * (rot - 90));
      tmp = 12;
      if(_root[d].hitTest(_root.h3._x,_root.h3._y,true))
      {
         tunnel = "on";
         if(g == "on")
         {
            if(roll != "on")
            {
               _root.fx.fx("dash");
               roll = "on";
            }
            if(0 < x && x < 4)
            {
               x = 7;
            }
            else if(x < 0 && -4 < x)
            {
               x = -7;
            }
            else if(tmp < x)
            {
               x = tmp;
            }
            else if(x < - tmp)
            {
               x = - tmp;
            }
         }
         else
         {
            this._y += y + 3;
            y = 0;
         }
      }
      setgrind();
      seth("h",0);
      if(x < 0)
      {
         seth("h1",- xplus);
      }
      else if(0 < x)
      {
         seth("h2",xplus);
      }
      else
      {
         seth("h1",- xplus);
         seth("h2",xplus);
      }
      if(Key.isDown(Key.END))
      {
         _root.h._visible = 0;
         _root.h1._visible = 0;
         _root.h2._visible = 0;
         _root.h3._visible = 0;
      }
      else if(Key.isDown(Key.HOME))
      {
         _root.h._visible = 1;
         _root.h1._visible = 1;
         _root.h2._visible = 1;
         _root.h3._visible = 1;
      }
      _root.h._x = Math.round(_root.h._x);
      _root.h._y = Math.round(_root.h._y);
      _root.h1._x = Math.round(_root.h1._x);
      _root.h1._y = Math.round(_root.h1._y);
      _root.h2._x = Math.round(_root.h2._x);
      _root.h2._y = Math.round(_root.h2._y);
      if(h == "on" || twistl != "off")
      {
         if(twistl == "off")
         {
            _Y = _root.h._y + m * Math.sin(0.017453292519943295 * (rot - 90));
            _X = _root.h._x + m * Math.cos(0.017453292519943295 * (rot - 90));
         }
         if(5 < rot || rot < -5)
         {
            x += 0.4 * Math.sin(0.017453292519943295 * rot);
         }
         if(g == "off" && land < 0)
         {
            landy = y;
            land = 2;
         }
         fly = "off";
         hit = "off";
         jhigh = "off";
         g = "on";
         j = "off";
         y = 0;
      }
      else
      {
         roll = "off";
         g = "off";
      }
      if(g == "on" && j != "on")
      {
         if(85 < rot || rot < -85)
         {
            if(!(5 < x || x < -5))
            {
               g = "off";
            }
         }
      }
      if(twistl == "off")
      {
         setrot();
      }
      if(land >= 0)
      {
         x -= landy * Math.sin(0.017453292519943295 * rot) / 2;
         land -= 1;
      }
      setpos();
      animations();
      if(roll == "on" && chara != "tails" && chara != "cream")
      {
         _rotation = 0;
      }
      else if(g == "on")
      {
         _rotation = rot;
      }
      else
      {
         _rotation = _rotation - (_rotation - rot) / 10;
      }
      if(_root.cheat[3] == 2)
      {
         cdepth = -1;
      }
      else if(twistl == "down")
      {
         cdepth = 3;
      }
      else if(d == "Level")
      {
         cdepth = 18;
      }
      else
      {
         cdepth = 8;
      }
      this.swapDepths(this.cdepth);
      if(chara == "cream")
      {
         _root.cheese.swapDepths(this.cdepth - 1);
      }
      if(_root.pause == 0)
      {
         if(chara == "tails" || chara == "cream")
         {
            if(fly != "off")
            {
               if(this.Sonic._currentframe == 180)
               {
                  if(fly >= 0)
                  {
                     fly -= 1;
                  }
               }
               else
               {
                  fly = "off";
               }
            }
         }
      }
      swing = "off";
      twistl = "off";
   }
}
