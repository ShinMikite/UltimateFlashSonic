onClipEvent(load){
   function music(track)
   {
      this.musicO.stop();
      this.musicO.setVolume(musicvol);
      this.musicO.attachSound("music_" add track);
      this.musicO.start(0,1000);
   }
   stopAllSounds();
   musicvol = _root.musicvol;
   this.musicO = new Sound(this);
}
