onClipEvent(enterFrame){
   if(this.hitTest(_root.h))
   {
      if(_root.Sonic1.x < 15)
      {
         _root.Sonic1.x = -15;
      }
      _root.fx.fx("speeder");
   }
}
