onClipEvent(enterFrame){
   if(_root.pause == 0)
   {
      if(0 < energy)
      {
         if(pinch < energy)
         {
            count += 1;
            if(50 < count)
            {
               _root.Level.setobject("obj_eggbomb",_root[getProperty("../", _name)]._x,_root[getProperty("../", _name)]._y + 20,0,0);
               _root.fx.fx("eggbomb");
               count = 0;
            }
         }
         else
         {
            count += 1;
            if(25 < count)
            {
               _root.Level.setobject("obj_eggbomb",_root[getProperty("../", _name)]._x,_root[getProperty("../", _name)]._y + 20,0,0);
               _root.fx.fx("eggbomb");
               count = 0;
            }
         }
      }
      else if(this._currentframe < this._totalframes)
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
      else
      {
         _root[getProperty("../", _name)]._y += y;
         _root[getProperty("../", _name)]._x += x;
         y += 1;
         if(_root[getProperty("../", _name)].hitTest(_root.level) && 0 < y)
         {
            y *= -0.5;
            x -= 2;
            if(y >= 1)
            {
               y = 0;
            }
         }
         if(_root[getProperty("../", _name)]._x < -20)
         {
            _root.attachMovie("Leveloutro","leveloutro",50);
            _root[getProperty("../", _name)].removeMovieClip();
         }
      }
      if(this._currentframe == 1)
      {
         if(this.hitTest(_root.Sonic1.hitb) && _root.Sonic1.j == "on" && _root.Sonic1.fly != "on")
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
               this.play();
            }
            else
            {
               _root.bossstat = "defeated";
               this.gotoAndPlay("explosion");
            }
         }
      }
   }
}
