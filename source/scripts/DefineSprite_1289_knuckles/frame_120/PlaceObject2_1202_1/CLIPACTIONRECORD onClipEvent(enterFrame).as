onClipEvent(enterFrame){
   if(3 >= eval("../../:y") && this._currentframe < 13)
   {
      this.gotoAndPlay(13);
   }
   else if(3 < eval("../../:y") && 13 < this._currentframe)
   {
      this.gotoAndPlay(1);
   }
}
