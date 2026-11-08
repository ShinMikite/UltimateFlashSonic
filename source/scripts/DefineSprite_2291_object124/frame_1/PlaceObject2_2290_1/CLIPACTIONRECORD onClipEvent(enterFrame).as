onClipEvent(enterFrame){
   if(_root.pause == 0)
   {
      if(eval("../:energy") >= 0)
      {
         if(attack != "off")
         {
            this.gotoAndStop("stand");
            count += 1;
            if(count >= 100)
            {
               attack = "off";
            }
            else if(count == 20)
            {
               glx = _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x + _root.Levelo["p" add eval("../:object")]._x + _root.Levelo._x;
               gly = _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y + _root.Levelo["p" add eval("../:object")]._y + _root.Levelo._y;
               _root.Level.setobject("obj_bomb",glx,gly,2,-5);
            }
         }
         else
         {
            _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y += y;
            this.gotoAndStop("move");
            if(starty + 10 < _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y)
            {
               _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y = starty + 10;
               y = - speed;
            }
            else if(_root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y < starty - 10)
            {
               _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y = starty - 10;
               y = speed;
               count = 0;
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
