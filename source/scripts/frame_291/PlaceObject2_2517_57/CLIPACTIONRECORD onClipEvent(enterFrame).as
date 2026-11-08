onClipEvent(enterFrame){
   if(track != "off")
   {
      if(0 < musicvol)
      {
         musicvol -= 10;
      }
      else
      {
         music(track);
         track = "off";
      }
   }
   else if(musicvol < _root.musicvol)
   {
      musicvol += 20;
   }
   else
   {
      musicvol = _root.musicvol;
   }
   this.musicO.setVolume(musicvol);
}
