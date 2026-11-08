onClipEvent(load){
   set("../:save","on");
   if(eval("../:energy") < 0)
   {
      this._visible = 0;
   }
}
