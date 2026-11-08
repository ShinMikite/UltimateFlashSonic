onClipEvent(enterFrame){
   lastX = this._x;
   lastY = this._y;
   if(_root.pause == 0 && _root.Sonic1.dead != "on")
   {
      if(_root.boss == "on")
      {
         bossspeed = 8;
         this._x -= bossspeed;
         if(10 >= _root.Sonic1._x)
         {
            _root.Sonic1._x = 10;
            _root.Sonic1.x = bossspeed;
         }
         else if(mw - 10 < _root.Sonic1._x)
         {
            _root.Sonic1._x = mw - 10;
            _root.Sonic1.x = bossspeed;
         }
         _root.Sonic1._x -= bossspeed;
         _root.bossobj._y = Math.round(_root.bossobj._y - (_root.Sonic1._y - h) / CameraSpeed);
      }
      else
      {
         camera();
      }
      this._y = Math.round(this._y - (_root.Sonic1._y - h) / CameraSpeed);
      if(maxY < y * pw - this._y + (_root.Sonic1._y - w))
      {
         _root.Sonic1.dead = "on";
      }
      _root.Sonic1._y = Math.round(_root.Sonic1._y - (_root.Sonic1._y - h) / CameraSpeed);
   }
   var a = 1;
   while(_root.lrtotal >= a)
   {
      _root["rl" add a]._x += this._x - lastX;
      _root["rl" add a]._y += this._y - lastY;
      a++;
   }
   var a = 1;
   while(_root.objtotal >= a)
   {
      _root["obj" add a]._x += this._x - lastX;
      _root["obj" add a]._y += this._y - lastY;
      a++;
   }
   lx = x;
   ly = y;
   if(this._x < - pwh)
   {
      x += 1;
      if(_root.boss == "on")
      {
         if(16 < x)
         {
            x = 1;
         }
      }
      this._x += pw;
      setlevel();
   }
   else if(pwh < this._x)
   {
      x -= 1;
      this._x -= pw;
      setlevel();
   }
   if(this._y < - pw)
   {
      y += 1;
      this._y += pw;
      setlevel();
   }
   else if(pwh < this._y)
   {
      y -= 1;
      this._y -= pw;
      setlevel();
   }
   _root.levelo._x = this._x;
   _root.levelo._y = this._y;
   _root.levelo2._x = this._x;
   _root.levelo2._y = this._y;
   _root.level2._x = this._x;
   _root.level2._y = this._y;
}
