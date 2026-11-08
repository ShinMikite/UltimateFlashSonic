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
   if(_root.level.lvlo[eval("../:lvlo") add "starty" add eval("../:objectn")] == "")
   {
      _root.level.lvlo[eval("../:lvlo") add "starty" add eval("../:objectn")] = _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._y;
   }
   startx = _root.Levelo["p" add eval("../:object")][getProperty("../", _name)]._x;
   starty = _root.level.lvlo[eval("../:lvlo") add "starty" add eval("../:objectn")];
   attack = "back";
}
