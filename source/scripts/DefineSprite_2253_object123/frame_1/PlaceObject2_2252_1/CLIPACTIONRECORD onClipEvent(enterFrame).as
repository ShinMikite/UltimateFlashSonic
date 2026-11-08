onClipEvent(enterFrame){
   if(_root.pause == 0)
   {
      if(eval("../:energy") >= 0)
      {
         if(attack != "off")
         {
            if(attack == "on")
            {
               if(_root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y >= ay - 1)
               {
                  attack = "back";
               }
               else
               {
                  _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x -= (_root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x - ax) / 20;
                  _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y -= (_root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y - ay - 10) / 20;
               }
            }
            else if(attack == "back")
            {
               if(starty + 1 >= _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y)
               {
                  _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y = starty;
                  count = 50;
                  attack = "off";
               }
               else
               {
                  _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x -= (_root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x - startx) / 10;
                  _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y -= (_root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y - starty) / 10;
               }
            }
         }
         else
         {
            if(_root.Level.pwh - 20 < _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x)
            {
               if(0 < x)
               {
                  x -= 0.5;
               }
               else
               {
                  x = - speed;
               }
            }
            else if(_root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x < - _root.Level.pwh + 20)
            {
               if(x < 0)
               {
                  x += 0.5;
               }
               else
               {
                  x = speed;
               }
            }
            _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x += x;
            glx = _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x + _root.Levelo["p" add eval("../:object")]._x + _root.Levelo._x;
            gly = _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y + _root.Levelo["p" add eval("../:object")]._y + _root.Levelo._y;
            if(0 >= count)
            {
               if(gly < _root.Sonic1._y)
               {
                  if(0 < _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._xscale && glx < _root.Sonic1._x && _root.Sonic1._x < glx + 50 || _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._xscale < 0 && _root.Sonic1._x < glx && glx - 50 < _root.Sonic1._x)
                  {
                     attack = "on";
                     startx = _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x;
                     ax = _root.Sonic1._x - _root.Levelo["p" add eval("../:object")]._x - _root.Levelo._x;
                     ay = _root.Sonic1._y - _root.Levelo["p" add eval("../:object")]._y - _root.Levelo._y;
                  }
               }
            }
            else
            {
               count -= 1;
            }
            if(0 < x)
            {
               _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._xscale = 100;
            }
            else
            {
               _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._xscale = -100;
            }
         }
         if(attack == "on")
         {
            this.gotoAndStop("attack");
         }
         else if(x == speed || x == - speed)
         {
            this.gotoAndStop("move");
         }
         else
         {
            this.gotoAndStop("turn");
         }
         if(this.hitTest(_root.Sonic1.hitb))
         {
            if(_root.Sonic1.roll == "on")
            {
               set("../:energy",eval("../:energy") - 1);
            }
            else if(_root.Sonic1.j == "on")
            {
               set("../:energy",eval("../:energy") - 1);
               if(_root.Sonic1.y < 0)
               {
                  _root.Sonic1.y *= -1;
               }
               _root.fx.fx("box");
               _root.score += _root.scorev.enemy;
            }
            else
            {
               _root.Sonic1.sethit();
            }
         }
      }
      else
      {
         this.gotoAndStop("explosion");
      }
   }
}
