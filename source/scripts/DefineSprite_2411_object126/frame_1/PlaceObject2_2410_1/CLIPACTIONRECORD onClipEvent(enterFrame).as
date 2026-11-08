onClipEvent(enterFrame){
   if(_root.pause == 0)
   {
      if(eval("../:energy") >= 0)
      {
         if(attack != "off")
         {
            this.gotoAndStop("attack");
            if(this.e._currentframe >= this.e._totalframes)
            {
               count += 1;
               if(count >= 20)
               {
                  attack = "off";
               }
               else if(count == 5)
               {
                  glx = _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x + _root.Levelo["p" add eval("../:object")]._x + _root.Levelo._x;
                  gly = _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y + _root.Levelo["p" add eval("../:object")]._y + _root.Levelo._y;
                  _root.Level.setobject("obj_laser",glx,gly + 30,0,0);
               }
            }
         }
         else
         {
            _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x += x;
            this.gotoAndStop("move");
            count = 0;
            if(_root.Level.pwh - 20 < _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x)
            {
               x = - speed;
               attack = "on";
            }
            else if(_root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x < - _root.Level.pwh + 20)
            {
               x = speed;
               attack = "on";
            }
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
