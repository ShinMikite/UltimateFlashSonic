onClipEvent(load){
   set("../:savepos","on");
   set("../:save","on");
   speed = 3;
   if(0 < _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._xscale)
   {
      x = speed;
   }
   else
   {
      x = - speed;
   }
   if(eval("../:energy") < 0)
   {
      this._visible = 0;
   }
}
