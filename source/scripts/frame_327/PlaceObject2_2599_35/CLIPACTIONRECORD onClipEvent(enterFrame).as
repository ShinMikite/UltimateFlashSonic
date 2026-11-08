onClipEvent(enterFrame){
   if(_root.rings < 10)
   {
      rings = "00" add _root.rings;
   }
   else if(_root.rings < 100)
   {
      rings = "0" add _root.rings;
   }
   else
   {
      rings = _root.rings;
   }
}
