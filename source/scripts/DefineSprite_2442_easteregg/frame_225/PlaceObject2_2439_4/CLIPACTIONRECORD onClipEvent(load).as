onClipEvent(load){
   var a = 1;
   while(20 >= a)
   {
      if(0 < _root[getProperty("../", _name)]["s" add a]._alpha)
      {
         _root[getProperty("../", _name)]["s" add a]._alpha -= 10;
      }
      else
      {
         _root[getProperty("../", _name)]["s" add a].removeMovieClip();
      }
      a++;
   }
}
