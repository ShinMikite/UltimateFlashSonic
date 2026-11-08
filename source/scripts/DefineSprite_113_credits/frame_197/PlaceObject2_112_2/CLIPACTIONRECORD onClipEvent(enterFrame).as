onClipEvent(enterFrame){
   if(0 >= z)
   {
      tellTarget(_root)
      {
         gotoAndStop("main_menu");
      }
      "../:removeMovieClip"();
   }
   else
   {
      z -= 4;
      _root.music.musicO.setVolume(z);
   }
}
