onClipEvent(enterFrame){
   if(this.hitTest(_root.h))
   {
      if(0 < _root.Sonic1.x)
      {
         _root.Sonic1.d = "Level2";
      }
      else
      {
         _root.Sonic1.d = "Level";
      }
   }
}
