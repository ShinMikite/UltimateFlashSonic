onClipEvent(enterFrame){
   if(this._name == "t1")
   {
      if(Key.isDown(Key.SPACE))
      {
         if(spacedown == "off")
         {
            if(skip == "on")
            {
               "../:gotoAndStop"(getProperty("../", _totalframes));
            }
            else
            {
               skip = "on";
            }
         }
         spacedown = "on";
      }
      else
      {
         spacedown = "off";
      }
      var a = 1;
      while(total >= a)
      {
         _root[getProperty("../", _name)]["t" add a]._y -= speed;
         if(skip == "on")
         {
            if(-150 < _root[getProperty("../", _name)]["t" add a]._alpha)
            {
               _root[getProperty("../", _name)]["t" add a]._alpha -= 5;
            }
            if(this._alpha < -100 && getProperty("../", _currentframe) == 1)
            {
               "../:play"();
            }
         }
         else if(_root[getProperty("../", _name)]["t" add a]._y < top)
         {
            if(0 < _root[getProperty("../", _name)]["t" add a]._alpha)
            {
               _root[getProperty("../", _name)]["t" add a]._alpha -= 5;
               _root[getProperty("../", _name)]["t" add a]._y -= speed;
            }
            else
            {
               if(credits[c add "-type"] == 2)
               {
                  _root[getProperty("../", _name)]["t" add a].gotoAndStop(2);
               }
               else
               {
                  _root[getProperty("../", _name)]["t" add a].gotoAndStop(1);
               }
               _root[getProperty("../", _name)]["t" add a].t = credits[c];
               c += 1;
               if(totalc < c)
               {
                  "../:play"();
               }
               _root[getProperty("../", _name)]["t" add a]._y = bot;
            }
         }
         else if(bot >= _root[getProperty("../", _name)]["t" add a]._y)
         {
            if(_root[getProperty("../", _name)]["t" add a]._alpha < 100)
            {
               _root[getProperty("../", _name)]["t" add a]._alpha += 5;
               _root[getProperty("../", _name)]["t" add a]._y -= speed;
            }
         }
         a++;
      }
   }
}
