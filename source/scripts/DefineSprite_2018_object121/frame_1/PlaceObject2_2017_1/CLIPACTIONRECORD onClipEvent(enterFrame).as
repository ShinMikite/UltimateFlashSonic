onClipEvent(enterFrame){
   if(_root.pause == 0)
   {
      if(eval("../:energy") >= 0)
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
         if(x == speed || x == - speed)
         {
            this.gotoAndStop("move");
         }
         else
         {
            this.gotoAndStop("turn");
         }
         if(0 < x)
         {
            _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._xscale = 100;
         }
         else
         {
            _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._xscale = -100;
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
