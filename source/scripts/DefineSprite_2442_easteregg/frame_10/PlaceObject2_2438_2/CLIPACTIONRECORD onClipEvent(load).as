onClipEvent(load){
   if(this._name == "s1")
   {
      startx = this._x;
      speed = 10;
      var a = 2;
      while(20 >= a)
      {
         duplicateMovieClip(this,"s" add a,16384 + a);
         _root[getProperty("../", _name)]["s" add a]._x = startx + random(200);
         _root[getProperty("../", _name)]["s" add a]._y = random(250);
         _root[getProperty("../", _name)]["s" add a].speed = random(10) + 5;
         _root[getProperty("../", _name)]["s" add a]._xscale = 50 + random(50);
         _root[getProperty("../", _name)]["s" add a]._alpha = 50 + random(50);
         _root[getProperty("../", _name)]["s" add a]._yscale = _root[getProperty("../", _name)]["s" add a]._xscale;
         _root[getProperty("../", _name)]["s" add a].gotoAndStop(1 + random(5));
         a++;
      }
   }
}
