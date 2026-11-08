onClipEvent(enterFrame){
   if(this._name == "s1")
   {
      var a = 1;
      while(20 >= a)
      {
         _root[getProperty("../", _name)]["s" add a]._x -= _root[getProperty("../", _name)]["s" add a].speed;
         if(_root[getProperty("../", _name)]["s" add a]._x < -100)
         {
            _root[getProperty("../", _name)]["s" add a]._x = startx;
         }
         a++;
      }
   }
}
