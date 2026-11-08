onClipEvent(enterFrame){
   if(this.hitTest(_root.h) && getProperty("../../", _name) == _root.Sonic1.d)
   {
      _root.Sonic1.grind = 2;
   }
}
