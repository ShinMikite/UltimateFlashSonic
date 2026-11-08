onClipEvent(enterFrame){
   if(10 >= z)
   {
      this._xscale -= (this._xscale - 150) / 3;
      this._yscale -= (this._yscale - 150) / 3;
      z += 1;
   }
   else
   {
      this.t = "RECORDS";
      this._x -= (this._x - startx) / 3;
      this._y -= (this._y - starty) / 3;
      this._xscale -= (this._xscale - 100) / 3;
      this._yscale -= (this._yscale - 100) / 3;
   }
}
