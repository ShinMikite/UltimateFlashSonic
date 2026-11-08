onClipEvent(enterFrame){
   if(this.hitTest(_root.Sonic1))
   {
      _root.Sonic1.sproing();
      _root.Sonic1._xscale = 100;
      _root.Sonic1.x = 15;
      "../:play"();
   }
}
