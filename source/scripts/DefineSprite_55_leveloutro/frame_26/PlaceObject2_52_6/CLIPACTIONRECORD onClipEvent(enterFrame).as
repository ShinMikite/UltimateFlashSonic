onClipEvent(enterFrame){
   if(stat == 1)
   {
      var a = 1;
      while(3 >= a)
      {
         if(190 < _root.leveloutro["s" add a]._x)
         {
            _root.leveloutro["s" add a]._x -= 20;
         }
         else
         {
            _root.leveloutro["s" add a]._x = 190;
         }
         a++;
      }
      if(_root.leveloutro.s3._x == 190)
      {
         count = 0;
         stat = 2;
      }
   }
   else if(stat == 2)
   {
      if(count >= 75)
      {
         count = 0;
         stat = 3;
      }
      else
      {
         count += 1;
      }
   }
   else if(stat == 3)
   {
      count = 0;
      var a = 1;
      while(2 >= a)
      {
         if(_root.leveloutro[this.sname[this.a]] / 100 >= 1)
         {
            step = 100;
         }
         else if(_root.leveloutro[this.sname[this.a]] / 10 >= 1)
         {
            step = 10;
         }
         else if(0 >= _root.leveloutro[this.sname[this.a]])
         {
            step = 0;
            count += 1;
         }
         else
         {
            step = 1;
         }
         _root.leveloutro[this.sname[this.a]] -= step;
         _root.leveloutro.score += step;
         a++;
      }
      _root.fx.fx("count");
      if(count >= 2 || Key.isDown(_root.Sonic1.jump))
      {
         _root.leveloutro.score += _root.leveloutro[this.sname[1]] + _root.leveloutro[this.sname[2]];
         _root.leveloutro[this.sname[1]] = 0;
         _root.leveloutro[this.sname[2]] = 0;
         count = 0;
         stat = 4;
      }
   }
   else if(stat == 4)
   {
      _root.fx.fx("cling");
      stat = 5;
   }
   else if(stat == 5)
   {
      if(count >= 50)
      {
         stat = 6;
         count = 1;
      }
      else
      {
         count += 1;
      }
   }
   else if(stat == 6)
   {
      var a = 1;
      while(count >= a)
      {
         if(-150 < _root.leveloutro["s" add a]._x)
         {
            _root.leveloutro["s" add a]._x -= 40;
         }
         else if(a == 3)
         {
            stat = 7;
         }
         if(a == count)
         {
            if(_root.leveloutro["s" add a]._x < 140)
            {
               if(count < 3)
               {
                  count += 1;
               }
               else
               {
                  "../:play"();
               }
            }
         }
         a++;
      }
   }
   else if(stat == 7)
   {
   }
   _root.score = _root.leveloutro.score;
}
