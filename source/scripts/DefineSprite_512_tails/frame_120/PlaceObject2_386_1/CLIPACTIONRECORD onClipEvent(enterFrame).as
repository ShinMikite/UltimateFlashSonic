onClipEvent(enterFrame){
   if(3 >= eval("../../:y") && this._currentframe < 9)
   {
      this.gotoAndPlay(10);
   }
   else if(3 < eval("../../:y") && 9 < this._currentframe)
   {
      this.gotoAndPlay(1);
   }
}
