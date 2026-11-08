onClipEvent(enterFrame){
   TB = Math.round(_root.getBytesTotal() / 1024);
   BLoaded = Math.round(_root.getBytesLoaded() / 1024);
   this.b._xscale = BLoaded / TB * 100;
   if(BLoaded >= 100 && this._currentframe == 1)
   {
      this.play();
   }
}
