onClipEvent(enterFrame){
   if(d == "on")
   {
      if(getProperty("../", _xmouse) < min)
      {
         this._x = -50;
      }
      else if(max < getProperty("../", _xmouse))
      {
         this._x = 25;
      }
      else
      {
         this._x = getProperty("../", _xmouse);
      }
   }
   set("../:val",Math.round((this._x + 50) / 75 * 100));
}
