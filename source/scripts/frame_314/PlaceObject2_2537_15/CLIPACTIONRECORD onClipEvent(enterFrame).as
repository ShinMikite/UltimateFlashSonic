onClipEvent(enterFrame){
   if(currentact != 0)
   {
      if(this._x < 820)
      {
         this._x += 20;
      }
      else if(_root.zoneimg._x >= 500)
      {
         if(currentact == "back")
         {
            _root.gotoAndStop("main_menu");
         }
         else
         {
            _root.czone = currentzone;
            _root.cact = currentact;
            _root.fade.play();
         }
      }
   }
   else if(405 < this._x)
   {
      this._x -= 20;
   }
   else
   {
      this._x = 405;
      if(currentzone == 0)
      {
         if(this["zone" add lastup]._x < -20)
         {
            this["zone" add lastup]._x += changespeed;
         }
         else
         {
            this["zone" add lastup]._x = -20;
            selectzone();
         }
      }
      else if(currentact == 0)
      {
         if(-220 < this["zone" add currentzone]._x)
         {
            this["zone" add currentzone]._x -= changespeed;
         }
         else
         {
            selectact();
            if(Key.isDown(Key.BACKSPACE) || this["zone" add currentzone].zone.b.d == "on")
            {
               _root.fx.fx("back");
               currentzone = 0;
            }
            this["zone" add currentzone]._x = -220;
         }
      }
   }
   _root.box._x = this["zone" add lastup]._x + this._x;
   if(zoneimg == 0 || eval("../:zoneimg").zoneimg._currentframe != zoneimg)
   {
      if(eval("../:zoneimg")._x < 0)
      {
         eval("../:zoneimg")._x *= 0.5;
      }
      else if(eval("../:zoneimg")._x < 15)
      {
         eval("../:zoneimg")._x += 5;
      }
      else if(eval("../:zoneimg")._x < 500)
      {
         eval("../:zoneimg")._x += 70;
      }
      else if(zoneimg != 0)
      {
         eval("../:zoneimg").zoneimg.gotoAndStop(this.zoneimg);
      }
   }
   else if(500 < eval("../:zoneimg")._x)
   {
      eval("../:zoneimg").zoneimg.gotoAndStop(this.zoneimg);
      _root.fx.fx("swish");
      eval("../:zoneimg")._x = -400;
      eval("../:zoneimg").t = _root.zone[zoneimg - 1];
   }
   else if(0 < eval("../:zoneimg")._x)
   {
      eval("../:zoneimg")._x += 70;
   }
   else
   {
      eval("../:zoneimg")._x *= 0.5;
   }
}
