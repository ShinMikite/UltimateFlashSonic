onClipEvent(enterFrame){
   if(_root.pause == 0)
   {
      if(0 < energy)
      {
         if(pinch < energy)
         {
            rot += 2;
            if(360 < rot)
            {
               rot -= 360;
            }
            this._rotation = rottype * Math.cos(0.017453292519943295 * rot);
         }
         else
         {
            if(rotspeed < 10)
            {
               rotspeed += 0.5;
            }
            this._rotation += rotspeed;
         }
      }
      else
      {
         if(eval("../:egg")._currentframe == 20)
         {
            eval("../:egg").play();
         }
         this._rotation *= 0.95;
         if(this._currentframe < this._totalframes)
         {
            if(0 < count)
            {
               count -= 1;
            }
            else
            {
               if(random(3) == 1)
               {
                  _root.fx.fx("bossexplosion");
               }
               count = 1;
            }
         }
      }
      eval("../:ball")._x = 98 * Math.cos(0.017453292519943295 * (this._rotation + 90));
      eval("../:ball")._y = 98 * Math.sin(0.017453292519943295 * (this._rotation + 90));
      if(eval("../:egg")._currentframe == 1)
      {
         if(eval("../:egg").hitTest(_root.Sonic1.hitb))
         {
            _root.Sonic1.x -= 12;
            _root.Sonic1.y *= -1;
            if(energy / 2 == Math.round(energy / 2))
            {
               _root.fx.fx("bosshit1");
            }
            else
            {
               _root.fx.fx("bosshit2");
            }
            energy -= 1;
            if(energy == pinch)
            {
               _root.music.music("boss_pinch",999999);
            }
            if(0 < energy)
            {
               eval("../:egg").play();
            }
            else
            {
               _root.bossstat = "defeated";
               eval("../:ball").play();
               eval("../:egg").gotoAndPlay("explosion");
               this.play();
            }
         }
      }
   }
}
