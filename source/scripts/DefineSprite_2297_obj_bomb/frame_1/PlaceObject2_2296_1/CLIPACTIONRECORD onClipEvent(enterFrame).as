onClipEvent(enterFrame){
   if(_root.pause == 0)
   {
      if(this.hitTest(_root.Sonic1.hitb) && _root.Sonic1.hit == "off" && this._visible == 1)
      {
         if(this._currentframe < 100)
         {
            this.gotoAndPlay("explosion");
         }
         _root.sonic1.sethit();
      }
      y += 0.5;
      if(_root.level.hitTest(_root[getProperty("../", _name)]._x,_root[getProperty("../", _name)]._y,true) || _root.level2.hitTest(_root[getProperty("../", _name)]._x,_root[getProperty("../", _name)]._y,true))
      {
         y *= -0.3;
         if(0 < y)
         {
            y = 0;
         }
         x *= 0.7;
      }
      _root[getProperty("../", _name)]._y += y;
      _root[getProperty("../", _name)]._x += x;
      this.play();
   }
   else
   {
      this.stop();
   }
   if(this._currentframe >= this._totalframes || 270 < _root[getProperty("../", _name)]._y)
   {
      _root[getProperty("../", _name)].removeMovieClip();
   }
}
