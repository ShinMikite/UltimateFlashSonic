onClipEvent(enterFrame){
   this.fx2.FXO = new Sound(this.fx2);
   this.fx2.FXO.setVolume(_root.FXvol);
   if(_root.Sonic1.br == "on" && _root.Sonic1.g == "on" && _root.Sonic1.roll != "on" && _root.pause == 0)
   {
      if(br != "on")
      {
         this.fx2.FXO.stop();
         this.fx2.FXO.attachSound("FX_break");
         this.fx2.FXO.start(0,1000);
         br = "on";
      }
   }
   else if(br == "on")
   {
      this.fx2.FXO.stop();
      br = "off";
   }
   if(_root.Sonic1.g == "on" && _root.pause == 0)
   {
      if(grind != _root.Sonic1.grind)
      {
         if(0 < _root.Sonic1.grind)
         {
            this.fx2.FXO.stop();
            this.fx2.FXO.attachSound("FX_startgrind");
            this.fx2.FXO.start(0,0);
            this.fx2.FXO.attachSound("FX_grind");
            this.fx2.FXO.start(0,1000);
         }
         else
         {
            this.fx2.FXO.stop();
         }
         grind = _root.Sonic1.grind;
      }
   }
   else
   {
      this.fx2.FXO.stop();
      grind = 0;
   }
}
