onClipEvent(load){
   function control_g()
   {
      br = "off";
      if(0 >= grind)
      {
         if(Key.isDown(right))
         {
            if(x < 0)
            {
               if(x < -5)
               {
                  br = "on";
               }
               x += accel * 3;
            }
            else
            {
               this._xscale = 100;
               if(x < xmaxa)
               {
                  x += accel;
               }
            }
         }
         else if(Key.isDown(left))
         {
            if(0 < x)
            {
               if(5 < x)
               {
                  br = "on";
               }
               x -= accel * 3;
            }
            else
            {
               this._xscale = -100;
               if(- xmaxa < x)
               {
                  x -= accel;
               }
            }
         }
         else if(rot < 10 && -10 < rot)
         {
            if(roll == "on")
            {
               slowdown("x",0,0.05);
            }
            else
            {
               slowdown("x",0,0.2);
            }
         }
      }
      duck = "off";
      look = "off";
      if(Key.isDown(down))
      {
         if(x == 0)
         {
            duck = "on";
         }
         else if(roll != "on")
         {
            _root.fx.fx("dash");
            roll = "on";
         }
      }
      else if(Key.isDown(up) && x == 0)
      {
         look = "on";
      }
      if(Key.isDown(jump) && g == "on" && tunnel != "on")
      {
         if(jumpdown == "off")
         {
            if(duck == "on")
            {
               _root.fx.fx("dash");
               dash = "on";
            }
            else
            {
               _root.fx.fx("jump");
               makejump();
            }
         }
         jumpdown = "on";
      }
      else
      {
         jumpdown = "off";
      }
      if(duck != "on" && dash == "on")
      {
         _root.fx.fx("dashoff");
         x = _xscale / 100 * 15;
         roll = "on";
         dash = "off";
      }
      if(roll == "on" && 2 >= x && x >= -2)
      {
         roll = "off";
      }
      tunnel = "off";
   }
   function control_a()
   {
      if(Key.isDown(right))
      {
         if(x < xmaxa)
         {
            x += accela;
         }
         this._xscale = 100;
      }
      else if(Key.isDown(left))
      {
         if(- xmaxa < x)
         {
            x -= accela;
         }
         this._xscale = -100;
      }
      else
      {
         slowdown("x",0,acce / 5);
      }
      if(Key.isDown(jump))
      {
         if(jumpdown == "off")
         {
            if(chara == "tails" || chara == "cream")
            {
               if(fly == "off")
               {
                  if(j == "on")
                  {
                     fly = 100;
                     j = "off";
                  }
               }
               else if(0 < fly)
               {
                  if(y < 2)
                  {
                     y += 1;
                  }
                  else
                  {
                     y = 2;
                  }
               }
            }
         }
         jumpdown = "on";
      }
      else
      {
         jumpdown = "off";
      }
   }
   function slowdown(name, to, value)
   {
      if(this[name] < to - value)
      {
         this[name] += value;
      }
      else if(to + value < this[name])
      {
         this[name] -= value;
      }
      else
      {
         this[name] = to;
      }
   }
   function setgravity()
   {
      if(fly == "off")
      {
         y -= gravity;
      }
      else
      {
         y -= gravity / 5;
         if(4 < y)
         {
            y = 4;
         }
      }
      if(y < -25)
      {
         y = -25;
      }
   }
   function setpos()
   {
      lx = _X;
      ly = _Y;
      if(xmax < x)
      {
         x = xmax;
      }
      else if(x < - xmax)
      {
         x = - xmax;
      }
      if(g == "on")
      {
         this._y += x * Math.sin(0.017453292519943295 * rot2);
      }
      else
      {
         _Y = _Y - y;
      }
      this._x += x * Math.cos(0.017453292519943295 * rot2);
   }
   function getrot(o1, o2)
   {
      _root.Abstx1 = _root[o2]._x - _root[o1]._x;
      _root.Absty1 = _root[o2]._y - _root[o1]._y;
      _root.AngleA2 = Math.atan2(_root.Abstx1,- _root.Absty1);
      _root.Grad2 = _root.AngleA2 / 0.017453292519943295;
      return _root.Grad2 - 90;
   }
   function makejump()
   {
      j = "on";
      _X = _X + 20 * Math.sin(0.017453292519943295 * rot);
      _Y = _Y + 20 * Math.sin(0.017453292519943295 * (rot - 90));
      y = jumpspeed * Math.sin(0.017453292519943295 * (rot + 90));
      y -= x * Math.sin(0.017453292519943295 * rot);
      x = x * Math.cos(0.017453292519943295 * rot) + 15 * Math.cos(0.017453292519943295 * (rot - 90));
      rot2 = 0;
      rot = 0;
   }
   function setrot()
   {
      balance = "off";
      if(0 < x)
      {
         rot0u2 = getrot("h","h2");
         rott = rot0u2;
      }
      else if(x < 0)
      {
         rot0u1 = getrot("h1","h");
         rott = rot0u1;
      }
      if(rot < rott - 180)
      {
         rot += 360;
      }
      else if(rott + 180 < rot)
      {
         rot -= 360;
      }
      if(rot - rott < - hwall2 || hwall2 < rot - rott)
      {
         if(0 < land)
         {
            if(g == "on")
            {
               if(rott < -180)
               {
                  rott += 360;
               }
               else if(180 < rott)
               {
                  rott -= 360;
               }
               if(rott < -180)
               {
                  rott += 360;
               }
               else if(180 < rott)
               {
                  rott -= 360;
               }
               rot = rott;
            }
         }
         else if(rot < 80 && -80 < rot)
         {
            if(x < 0 && rot - rott < - _root.text)
            {
               _X = lx;
               x = 1;
            }
            else if(0 < x && _root.text < rot - rott)
            {
               _X = lx;
               x = -1;
            }
            else if(x == 0)
            {
               balance = "on";
            }
         }
      }
      else if(g == "on")
      {
         rot = Math.round(rott);
      }
      rot2 = rot;
      if(g != "on")
      {
         if(rot != 0 && j != "on")
         {
            y = - x * Math.sin(0.017453292519943295 * rot2);
            x *= Math.cos(0.017453292519943295 * rot2);
            rot2 = 0;
            rot = 0;
         }
      }
   }
   function seth(name, abst)
   {
      hstarty = this._y + abst * Math.sin(0.017453292519943295 * rot);
      hstartx = this._x + abst * Math.cos(0.017453292519943295 * rot);
      this[name] = "off";
      var a = -15;
      while(10 >= a)
      {
         _root[name]._y = hstarty + (m + a) * Math.sin(0.017453292519943295 * (rot + 90));
         _root[name]._x = hstartx + (m + a) * Math.cos(0.017453292519943295 * (rot + 90));
         if(_root[d].hitTest(_root[name]._x,_root[name]._y,true) || _root.levelo2.hitTest(_root[name]._x,_root[name]._y,true))
         {
            this[name] = "on";
            a = 100;
            break;
         }
         a += 1;
      }
   }
   function animations()
   {
      if(dead == "on")
      {
         this.sonic.gotoAndStop("dead");
      }
      else if(hit == "on")
      {
         this.sonic.gotoAndStop("hit");
      }
      else if(swing == "on")
      {
         this.Sonic.gotoAndStop("swing");
      }
      else if(fly != "off")
      {
         this.sonic.gotoAndStop("fly");
      }
      else if(jhigh == "on")
      {
         this.sonic.gotoAndStop("jumphigh");
      }
      else if(twistl != "off")
      {
         this.sonic.gotoAndStop("twistl");
      }
      else if(j == "on")
      {
         this.sonic.gotoAndStop("jump");
      }
      else if(roll == "on")
      {
         this.sonic.gotoAndStop("roll");
      }
      else if(dash == "on")
      {
         this.sonic.gotoAndStop("dash");
      }
      else if(0 < grind)
      {
         this.sonic.gotoAndStop("grind");
      }
      else if(duck == "on")
      {
         this.sonic.gotoAndStop("duck");
      }
      else if(look == "on")
      {
         this.sonic.gotoAndStop("look");
      }
      else if(balance == "on")
      {
         this.sonic.gotoAndStop("balance");
      }
      else if(g == "on")
      {
         if(push == "on")
         {
            this.sonic.gotoAndStop("push");
            push = "off";
         }
         else if(br == "on")
         {
            this.sonic.gotoAndStop("break");
         }
         else if(x != 0)
         {
            if((11 < x || x < -11) && chara == "sonic" || (13 < x || x < -13))
            {
               if(chara == "sonic" && _root.cheat[1] == 2)
               {
                  this.sonic.gotoAndStop("runfast2");
               }
               else
               {
                  this.sonic.gotoAndStop("runfast");
               }
            }
            else if(8 < x || x < -8)
            {
               this.sonic.gotoAndStop("run");
            }
            else if(4 < x || x < -4)
            {
               this.sonic.gotoAndStop("runslow");
            }
            else
            {
               this.sonic.gotoAndStop("walk");
            }
         }
         else
         {
            this.sonic.gotoAndStop("stand");
         }
      }
   }
   function setgrind()
   {
      if(0 < grind && g == "on")
      {
         roll = "off";
         if(0 < x)
         {
            this._xscale = 100;
         }
         else if(x < 0)
         {
            this._xscale = -100;
         }
         grind -= 1;
      }
   }
   function sethit()
   {
      if(dead != "on")
      {
         if(hit != "on")
         {
            if(0 < _root.rings)
            {
               this._y -= 20;
               y = 5;
               g = "off";
               hit = "on";
               x = (- _xscale) / 100 * 5;
               looserings();
            }
            else
            {
               y = 10;
               dead = "on";
            }
         }
      }
   }
   function looserings()
   {
      if(_root.lrtotal < _root.rings)
      {
         _root.lrs = _root.lrtotal;
      }
      else
      {
         _root.lrs = _root.rings;
      }
      _root.rings = 0;
      var a = 1;
      while(_root.lrs >= a)
      {
         _root.attachMovie("ringloose","rl" add a,a + 20);
         lrot = 90 + a / _root.lrs * 360;
         _root.fx.fx("loosering");
         _root["rl" add a]._x = this._x + 5 * Math.sin(0.017453292519943295 * lrot);
         _root["rl" add a]._y = this._y + 5 * Math.cos(0.017453292519943295 * lrot);
         _root["rl" add a].r.x = 5 * Math.sin(0.017453292519943295 * lrot);
         _root["rl" add a].r.y = 5 * Math.cos(0.017453292519943295 * lrot);
         a++;
      }
   }
   function sproing()
   {
      _root.fx.fx("sproing");
   }
   _root.h._visible = 0;
   _root.h1._visible = 0;
   _root.h2._visible = 0;
   _root.h3._visible = 0;
   _root.pause = 2;
   fin = "off";
   _root.rings = 0;
   _root.lrtotal = 25;
   chara = _root.chara;
   this.attachMovie(chara,"sonic",1);
   up = "38";
   down = "40";
   left = "37";
   right = "39";
   Jump = "32";
   dead = "off";
   m = 12;
   d = "Level";
   rot = 0;
   g = "off";
   x = 0;
   y = 0;
   if(_root.cheat[5] == 2)
   {
      gravity = 0.25;
   }
   else
   {
      gravity = 0.5;
   }
   Jumpspeed = 9;
   if(_root.cheat[5] == 2)
   {
      accel = 0.05;
      accela = 0.08;
   }
   else
   {
      accel = 0.15;
      accela = 0.15;
   }
   xmaxa = 12;
   xmax = 17;
   grind = 0;
   if(_root.cheat[2] == 2 && _root.chara != "tails")
   {
      _root.attachMovie("tails_follow","cheese",20);
      _root.cheese._x = this._x;
      _root.cheese._y = this._y;
   }
   else if(chara == "cream")
   {
      _root.attachMovie("cheese","cheese",20);
      _root.cheese._x = this._x;
      _root.cheese._y = this._y;
   }
}
