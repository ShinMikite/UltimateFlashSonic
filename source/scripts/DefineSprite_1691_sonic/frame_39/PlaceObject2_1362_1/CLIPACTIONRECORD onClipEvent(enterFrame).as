onClipEvent(enterFrame){
   if(count >= 12)
   {
      set("../:runframe",eval("../:runframe") + 1);
      if(this._totalframes < eval("../:runframe"))
      {
         set("../:runframe",1);
      }
      this.gotoAndStop(eval("../:runframe"));
      count = 0;
   }
   if(eval("../../:g") == "on")
   {
      if(0 < eval("../../:x"))
      {
         skip = eval("../../:x");
      }
      else
      {
         skip = - eval("../../:x");
      }
   }
   count += skip;
}
