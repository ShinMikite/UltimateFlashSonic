onClipEvent(load){
   function selectzone()
   {
      zoneimg = 0;
      var a = 1;
      while(zones >= a)
      {
         if(this["zone" add a].zone.b.r == "on")
         {
            this["zone" add a].zone._x -= (this["zone" add a].zone._x + 50) / 3;
            if(currentzone == 0)
            {
               zoneimg = a + 1;
            }
         }
         else
         {
            this["zone" add a].zone._x -= (this["zone" add a].zone._x + 42) / 3;
         }
         if(this["zone" add a].zone.b.d == "on")
         {
            changezone(a);
         }
         a++;
      }
      if(this["zone" add (zones + 1)].zone.b.r == "on")
      {
         this["zone" add (zones + 1)].zone._x -= (this["zone" add (zones + 1)].zone._x + 42) / 3;
      }
      else
      {
         this["zone" add (zones + 1)].zone._x -= (this["zone" add (zones + 1)].zone._x + 30) / 3;
      }
      if(this["zone" add (zones + 1)].zone.b.d == "on")
      {
         currentact = "back";
      }
   }
   function changezone(to)
   {
      this["zone" add to].swapDepths(this["zone" add lastup]);
      currentzone = to;
      this["zone" add currentzone].zone._x = -42;
      _root.fx.fx("select");
      var a2 = 1;
      while(100 >= a2)
      {
         if(0 < _root.act[currentzone add "-" add a2].length)
         {
            if(a2 == 1)
            {
               _root.box["b" add a2].t = _root.act[currentzone add "-" add a2];
            }
            else
            {
               duplicateMovieClip(_root.box.b1,"b" add a2,16384 + a2);
               _root.box["b" add a2]._y += (a2 - 1) * 20;
               _root.box["b" add a2].t = _root.act[currentzone add "-" add a2];
            }
         }
         else
         {
            acts = a2 - 1;
            if(0 >= _root.act[lastup add "-" add a2].length)
            {
               break;
            }
            _root.box["b" add a2].removeMovieClip();
         }
         a2++;
      }
      lastup = to;
   }
   function selectact()
   {
      var a = 1;
      while(acts >= a)
      {
         if(_root.box["b" add a].d == "on")
         {
            changeact(a);
         }
         a++;
      }
   }
   function changeact(to)
   {
      currentact = to;
      zoneimg = 0;
      var a = 1;
      while(4 >= a)
      {
         if(a != 1)
         {
            duplicateMovieClip(_root.box2.b1,"b" add a,16384 + a);
         }
         if(a == 4)
         {
            _root.box2["b" add a]._y = _root.box2.b1._y + 100;
         }
         else
         {
            _root.box2["b" add a]._y = _root.box2.b1._y + (a - 1) * 20;
         }
         a++;
      }
      _root.box2.b1.t = _root.act[currentzone add "-" add currentact];
      _root.box2.b2.t = "best time: " add _root.record[currentzone add "-" add currentact];
      _root.box2.b3.t = "character: " add _root.record[currentzone add "-" add currentact add "-char"];
      _root.box2.b4.t = "back";
   }
   this._x += 200;
   changespeed = 30;
   currentzone = 0;
   currentact = 0;
   var a = 1;
   while(100 >= a)
   {
      if(0 >= _root.zone[a].length)
      {
         zones = a - 1;
         lastup = a - 1;
         duplicateMovieClip(this.zone1,"zone" add a,16384 + a);
         this["zone" add a].zone._y = 147;
         this["zone" add a].zone.b.t = "BACK";
         break;
      }
      if(a == 1)
      {
         this["zone" add a].zone.b.t = _root.zone[a];
      }
      else
      {
         duplicateMovieClip(this.zone1,"zone" add a,16384 + a);
         this["zone" add a].zone._y += (a - 1) * 25;
         this["zone" add a].zone.b.t = _root.zone[a];
      }
      a++;
   }
}
