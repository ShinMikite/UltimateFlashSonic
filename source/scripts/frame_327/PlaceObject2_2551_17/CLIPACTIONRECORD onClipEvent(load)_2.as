onClipEvent(load){
   function camera()
   {
      if(maxX < x * pw - this._x + (_root.Sonic1._x - w))
      {
         if(mw < _root.Sonic1._x)
         {
            _root.Sonic1.x = 0;
            _root.Sonic1._x = mw;
            if(_root.Sonic1.fin == "on" && _root.Sonic1._visible != 0)
            {
               _root.Sonic1._visible = 0;
               _root.attachMovie("Leveloutro","leveloutro",50);
            }
         }
      }
      else
      {
         this._x = Math.round(this._x - (_root.Sonic1._x - w) / CameraSpeed);
         _root.Sonic1._x = Math.round(_root.Sonic1._x - (_root.Sonic1._x - w) / CameraSpeed);
      }
   }
}
