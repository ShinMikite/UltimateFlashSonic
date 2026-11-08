onClipEvent(enterFrame){
   if(this.hitTest(_root.h))
   {
      _root.Sonic1.fin = "on";
      _root.fx.fx("finishsign");
      "../:play"();
   }
   else if(_root.Sonic1.fin != "off")
   {
      "../:play"();
   }
}
