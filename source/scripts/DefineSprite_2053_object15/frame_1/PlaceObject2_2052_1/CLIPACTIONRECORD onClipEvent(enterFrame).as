onClipEvent(enterFrame){
   if(this.hitTest(_root.h) && _root.Sonic1.g == "on" && _root.Sonic1.j != "on")
   {
      if(5 < _root.Sonic1.x || _root.Sonic1.x < -5)
      {
         temp = _root.Sonic1._x - (_root.levelo._x + _root.Levelo["p" add eval("../:object")]._x - _root.Level.pwh) - 90;
         _root.Sonic1._y = -4 + _root.levelo._y + _root.Levelo["p" add eval("../:object")]._y + _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y - 25 * Math.sin(0.017453292519943295 * temp);
         _root.Sonic1.rot = 0;
         _root.Sonic1.y = 0;
         _root.Sonic1.g = "on";
         _root.Sonic1.twistl = "down";
         _root.Sonic1.Sonic.Sonic.gotoAndStop(Math.round((temp + 90) / 180 * 6));
      }
   }
}
