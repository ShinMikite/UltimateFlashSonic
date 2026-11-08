onClipEvent(load){
   set("../:savepos","off");
   set("../:save","on");
   set("../:save2","on");
   speed = 1;
   if(0 < _root.level.lvlo[eval("../:lvlo") add "xscale" add eval("../:objectn")])
   {
      y = speed;
   }
   else
   {
      y = - speed;
   }
   if(eval("../:energy") < 0)
   {
      this._visible = 0;
   }
   _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y = starty = _root.level.lvlo[eval("../:lvlo") add "yposS" add eval("../:objectn")];
   starty = _root.level.lvlo[eval("../:lvlo") add "ypos" add eval("../:objectn")];
   attack = "off";
}
