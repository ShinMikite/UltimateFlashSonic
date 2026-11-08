onClipEvent(enterFrame){
   if(this.hitTest(_root.h))
   {
      _root.Sonic1.sproing();
      _root.Sonic1._y -= 20;
      _root.Sonic1._x += 20;
      _root.Sonic1.jhigh = "on";
      _root.Sonic1.j = "off";
      _root.Sonic1.g = "off";
      _root.Sonic1.rot = 0;
      _root.Sonic1.rot2 = 0;
      _root.Sonic1.y = -12;
      _root.Sonic1.x = 10;
      "../:play"();
   }
}
