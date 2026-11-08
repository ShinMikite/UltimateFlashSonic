onClipEvent(enterFrame){
   if(this.h.hitTest(_root.h))
   {
      if(this._currentframe == 1)
      {
         _root.Sonic1.jhigh = "off";
         _root.Sonic1.hit = "off";
         _root.Sonic1.fly = "off";
         _root.Sonic1.j = "on";
         if(_root.Sonic1.y < 0)
         {
            _root.Sonic1.y = 0;
            _root.Sonic1.x = 0;
            this.play();
         }
      }
      else if(this._currentframe < 10)
      {
         _root.Sonic1.y = 0;
         _root.Sonic1.x = 0;
         _root.Sonic._y += 1;
         this.play();
      }
      else if(this._currentframe == 10)
      {
         if(0 < _root.levelo["p" add eval("../:object")][getProperty("../", _name)]._xscale)
         {
            temp = _root.Sonic1._x - (_root.levelo._x + _root.Levelo["p" add eval("../:object")]._x + _root.levelo["p" add eval("../:object")][getProperty("../", _name)]._x);
         }
         else
         {
            temp = _root.levelo._x + _root.Levelo["p" add eval("../:object")]._x + _root.levelo["p" add eval("../:object")][getProperty("../", _name)]._x - _root.Sonic1._x;
         }
         _root.Sonic1.y = Math.round(temp / 4) + 5;
         _root.Sonic1.x = 0;
      }
   }
}
