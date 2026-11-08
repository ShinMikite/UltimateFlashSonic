onClipEvent(load){
   function FX(track)
   {
      this.fx1.FXO.stop();
      this.fx1.FXO.setVolume(_root.FXvol);
      this.fx1.FXO.attachSound("FX_" add track);
      this.fx1.FXO.start(0,0);
   }
   this.fx1.FXO = new Sound(this.fx1);
   this.fx1.FXO = new Sound(this);
}
