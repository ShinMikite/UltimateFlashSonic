onClipEvent(enterFrame){
   if(remove == "on")
   {
      if(this._x < 10)
      {
         this._x += 2;
      }
      else if(this._x < chx)
      {
         this._x += 50;
      }
   }
   else if(current != current2)
   {
      if(this._x < 10)
      {
         this._x += 2;
      }
      else if(this._x < chx)
      {
         this._x += 50;
      }
      else
      {
         this._x = -300;
         current = current2;
         setbuttons();
      }
   }
   else
   {
      this._x *= 0.5;
      this[current add "f"]();
   }
}
