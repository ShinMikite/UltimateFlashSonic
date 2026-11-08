onClipEvent(enterFrame){
   if(3 >= eval("../../:y") && this._currentframe < 10)
   {
      this.gotoAndPlay(10);
   }
   else if(3 < eval("../../:y") && 10 < this._currentframe)
   {
      this.gotoAndPlay(1);
   }
}
