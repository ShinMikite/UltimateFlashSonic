onClipEvent(load){
   this._visible = 0;
   this.swapDepths(70);
   if(_root.unlock[3] == 1)
   {
      this.gotoAndStop(2);
   }
   else
   {
      this.gotoAndStop(1);
   }
}
