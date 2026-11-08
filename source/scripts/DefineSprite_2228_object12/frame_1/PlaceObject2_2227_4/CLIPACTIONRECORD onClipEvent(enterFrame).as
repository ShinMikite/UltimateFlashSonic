onClipEvent(enterFrame){
   if(this.hitTest(_root.h) && _root.Sonic1.g == "on")
   {
      _root.Sonic1.sethit();
   }
}
