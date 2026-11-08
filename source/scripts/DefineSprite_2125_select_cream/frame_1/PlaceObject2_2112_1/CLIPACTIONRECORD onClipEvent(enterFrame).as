onClipEvent(enterFrame){
   this.gotoAndStop(getProperty("../", _currentframe));
   if(_root.cheat[4] == 2)
   {
      scale = 200;
   }
   else
   {
      scale = 100;
   }
   this._xscale -= (this._xscale - scale) / 10;
   this._yscale = this._xscale;
}
