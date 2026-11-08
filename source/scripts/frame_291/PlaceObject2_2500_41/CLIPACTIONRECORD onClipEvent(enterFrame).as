onClipEvent(enterFrame){
   if(1 < this.character._currentframe)
   {
      if(this.character._currentframe >= this.character._totalframes - 1)
      {
         this.character.gotoAndStop(this.character._totalframes - 1);
         if(0 < count)
         {
            count -= 1;
         }
         else
         {
            if(-200 < this._x)
            {
               this._x -= 30;
            }
            if(_root.balken._x < 700)
            {
               _root.balken._x += 40;
            }
            _root.m.remove = "on";
            if(this._x < -200)
            {
               if(_root.m.gotoframe != "off")
               {
                  _root.gotoAndStop([_root.m.gotoframe]);
               }
               else if(_root.mode == "main")
               {
                  if(1 >= Number(_root.save[_root.chara]))
                  {
                     _root.czone = 1;
                     _root.cact = 1;
                     _root.fade.play();
                  }
                  else
                  {
                     _root.gotoAndStop("Levelselect");
                  }
               }
               else
               {
                  _root.gotoAndStop("Levelselect");
               }
            }
         }
      }
   }
   else if(chara != _root.chara)
   {
      _root.fx.fx("swish");
      this._x = startx + 100;
      this.attachMovie(["select_" add _root.chara],"character",1);
      this.character.stop();
      eval("../:balken")._y = 240;
      _root.balken.chara = this[_root.chara];
      eval("../:balken").balken.gotoAndStop([_root.chara]);
      eval("../:balken").gotoAndPlay(1);
      chara = _root.chara;
   }
   else if(startx < this._x)
   {
      this._x -= 20;
   }
   eval("../:balken")._y = Math.round(eval("../:balken")._y - (eval("../:balken")._y - bto) / 3);
}
