onClipEvent(enterFrame){
   if(_root.pause == 1)
   {
      if(this._visible == 0)
      {
         this._visible = 1;
         _root.fx.fx("pause");
      }
      _root.music.musicO.setVolume(_root.musicvol / 3);
   }
   else
   {
      this._visible = 0;
      _root.music.musicO.setVolume(_root.musicvol);
   }
}
