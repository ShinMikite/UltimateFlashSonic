onClipEvent(enterFrame){
   if(_root.pause == 0)
   {
      if(this.hitTest(_root.Sonic1.hitb) && _root.Sonic1.hit == "off")
      {
         this.gotoAndStop(2);
      }
      y += 0.5;
      if(_root[_root.Sonic1.d].hitTest(_root[getProperty("../", _name)]._x,_root[getProperty("../", _name)]._y,true))
      {
         y *= -0.7;
         if(-3 < y)
         {
            y = -3;
         }
         x *= 0.7;
      }
      _root[getProperty("../", _name)]._y += y;
      _root[getProperty("../", _name)]._x += x;
      if(270 < _root[getProperty("../", _name)]._y)
      {
         _root[getProperty("../", _name)].removeMovieClip();
      }
   }
}
