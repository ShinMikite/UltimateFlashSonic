onClipEvent(enterFrame){
   if(0 < _root.Sonic1.x)
   {
      abst = 30 + _root.Sonic1.x * 3;
   }
   else
   {
      abst = 30 - _root.Sonic1.x * 3;
   }
   rot = 270 + _root.Sonic1._xscale / 100 * 120;
   if(_root[getProperty("../", _name)]._x < _root.Sonic1._x)
   {
      _root[getProperty("../", _name)]._xscale = 100;
   }
   else
   {
      _root[getProperty("../", _name)]._xscale = -100;
   }
   if(0 >= _root.Sonic1.fly && _root.Sonic1.Sonic._currentframe == 180)
   {
      x -= (x - _root.Sonic1._x - _root.Sonic1._xscale / 100 * -5) / 8;
      y -= (y - _root.Sonic1._y + 10) / 8;
      this.gotoAndStop("hold");
   }
   else if(_root.Sonic1.look == "on")
   {
      x -= (x - _root.Sonic1._x - _root.Sonic1._xscale / 100 * -20) / 8;
      y -= (y - _root.Sonic1._y + 30) / 8;
      this.gotoAndStop("look");
   }
   else
   {
      y -= (y - _root.Sonic1._y + abst * Math.sin(0.017453292519943295 * (_root.Sonic1.rot + rot))) / 10;
      x -= (x - _root.Sonic1._x + abst * Math.cos(0.017453292519943295 * (_root.Sonic1.rot + rot))) / 10;
      if(_root.Sonic1.x < 3 && -3 < _root.Sonic1.x)
      {
         this.gotoAndStop("stand");
      }
      else if(_root.Sonic1.x < 10 && -10 < _root.Sonic1.x)
      {
         this.gotoAndStop("fly");
      }
      else
      {
         this.gotoAndStop("fly fast");
      }
   }
   _root[getProperty("../", _name)]._y = Math.round(y);
   _root[getProperty("../", _name)]._x = Math.round(x);
}
