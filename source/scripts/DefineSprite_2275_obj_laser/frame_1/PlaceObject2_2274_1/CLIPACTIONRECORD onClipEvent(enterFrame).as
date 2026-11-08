onClipEvent(enterFrame){
   if(_root.pause == 0)
   {
      if(this.hitTest(_root.Sonic1.hitb) && _root.Sonic1.hit == "off" && this._visible == 1)
      {
         this._visible = 0;
         _root.sonic1.sethit();
      }
      _root[getProperty("../", _name)]._y += 10;
      if(270 < _root[getProperty("../", _name)]._y)
      {
         _root[getProperty("../", _name)].removeMovieClip();
      }
   }
}
