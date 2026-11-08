onClipEvent(load){
   z = 10;
   startx = this._x;
   starty = this._y;
   this._x -= (this._x - 150) / 3;
   this._y -= (this._y - 100) / 3;
   this._xscale = 150;
   this._yscale = 150;
   this._y = 300;
}
