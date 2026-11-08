onClipEvent(enterFrame){
   Abstx1 = - eval("../../:x");
   Absty1 = eval("../../:y");
   AngleA2 = Math.atan2(Abstx1,- Absty1);
   if(0 < getProperty("../../", _xscale))
   {
      this._rotation = AngleA2 / 0.017453292519943295;
   }
   else
   {
      this._rotation = - AngleA2 / 0.017453292519943295;
   }
}
