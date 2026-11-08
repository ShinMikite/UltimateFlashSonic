onClipEvent(load){
   set("../:savepos","on");
   set("../:save","on");
   speed = 2;
   if(0 < _root.level.lvlo[eval("../:lvlo") add "xscale" add eval("../:objectn")])
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
   attack = "off";
}
