onClipEvent(enterFrame){
   if(_root.pause == 0)
   {
      if(this.hitTest(_root.Sonic1))
      {
         _root.Sonic1.j = "off";
         _root.Sonic1.hit = "off";
         _root.Sonic1.y = 0;
         _root.Sonic1.x = 0;
         if(sound == "off")
         {
            _root.fx.fx("speeder");
            sound = "done";
         }
         _root.Sonic1.swing = "on";
         _root.Sonic1._x = _root.levelo._x + _root.Levelo["p" add eval("../:object")]._x + _root.levelo["p" add eval("../:object")][getProperty("../", _name)]._x;
         _root.Sonic1._y = _root.levelo._y + _root.Levelo["p" add eval("../:object")]._y + _root.levelo["p" add eval("../:object")][getProperty("../", _name)]._y;
         rot = Math.round(_root.Sonic1.Sonic.Sonic._currentframe / _root.Sonic1.Sonic.Sonic._totalframes * 360);
         if(0 < _root.Sonic1._xscale)
         {
            rot -= 180;
            rot += corr;
            rot2 = (rot - corr) * -1;
         }
         else
         {
            rot += corr;
            rot2 = rot - corr;
         }
         _root.Sonic1._x += 10 * Math.cos(0.017453292519943295 * rot2);
         _root.Sonic1._y += 10 * Math.sin(0.017453292519943295 * rot2);
         this._rotation = rot2 - 90;
         if(Key.isDown(Key.SPACE))
         {
            if(downdown == "off")
            {
               _root.Sonic1.x = speed * Math.cos(0.017453292519943295 * rot);
               if(0 < _root.Sonic1._xscale)
               {
                  _root.Sonic1.y = speed * Math.sin(0.017453292519943295 * rot);
               }
               else
               {
                  _root.Sonic1.y = (- speed) * Math.sin(0.017453292519943295 * rot);
               }
               _root.Sonic1.j = "on";
               _root.Sonic1.jhigh = "off";
               _root.Sonic1.jumpdown = "on";
               "../:play"();
            }
            downdown = "on";
         }
         else
         {
            downdown = "off";
         }
      }
   }
}
