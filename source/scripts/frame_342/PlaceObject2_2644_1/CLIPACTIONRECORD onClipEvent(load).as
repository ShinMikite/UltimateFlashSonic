onClipEvent(load){
   function music(track, loop)
   {
      this.musicO.stop();
      this.musicO.setVolume(_root.musicvol);
      this.musicO.attachSound("music_" add track);
      this.musicO.start(0,loop);
   }
   stopAllSounds();
   this.musicO = new Sound(this);
}
