onClipEvent(enterFrame){
   if(this.hitTest(_root.h) || this.hitTest(_root.h1) || this.hitTest(_root.h2))
   {
      if(!(_root.Soni1rot < 80 && -80 < _root.Sonic1.rot))
      {
         if(_root.Sonic1.x < 15)
         {
            _root.fx.fx("speeder");
            _root.Sonic1.x = 15;
         }
      }
   }
}
