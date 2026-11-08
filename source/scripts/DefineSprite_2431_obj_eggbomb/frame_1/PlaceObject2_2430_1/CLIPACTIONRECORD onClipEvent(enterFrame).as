onClipEvent(enterFrame){
   if(_root.pause == 0)
   {
      if(this._currentframe == 1)
      {
         this._y += 8;
         if(this.hitTest(_root.level))
         {
            _root.fx.fx("bossexplosion");
            this.gotoAndStop("explosion");
         }
         _root[getProperty("../", _name)]._x = _root.bossobj._x;
      }
      else if(this.b._currentframe >= this.b._totalframes)
      {
         _root[getProperty("../", _name)].removeMovieClip();
      }
      if(this.b.hitTest(_root.Sonic1))
      {
         _root.Sonic1.sethit();
      }
      this.b.play();
   }
   else
   {
      this.b.stop();
   }
}
