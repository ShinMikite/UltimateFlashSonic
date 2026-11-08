onClipEvent(load){
   stop();
   count = 0;
   if(this._totalframes < eval("../:runframe"))
   {
      set("../:runframe",1);
   }
}
