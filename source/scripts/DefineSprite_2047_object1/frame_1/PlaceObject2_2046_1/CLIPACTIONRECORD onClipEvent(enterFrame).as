onClipEvent(enterFrame){
   if(this._visible == 1)
   {
      if(eval("../:energy") >= 0)
      {
         if(this.hitTest(_root.Sonic1.hitb))
         {
            set("../:energy",eval("../:energy") - 1);
         }
      }
      else
      {
         this.gotoAndStop(2);
      }
   }
}
