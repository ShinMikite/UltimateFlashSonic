onClipEvent(load){
   function setbuttons()
   {
      a = 1;
      this.b1.t = this[current][a].toUpperCase();
      a2start = 1;
      var a = 2;
      while(10 >= a)
      {
         if(0 < this[current][a].length || current == "cheats" && 7 >= a2start)
         {
            if(current == "cheats")
            {
               a2 = a2start;
               while(7 >= a2)
               {
                  if(!(_root.cheat[a2] == 0 || a2 == 7))
                  {
                     this["b" add a].d = "off";
                     duplicateMovieClip(this.b1,"b" add a,16384 + a);
                     this["b" add a].t = _root.cheat[a2 add "-name"].toUpperCase();
                     this["b" add a].cn = a2;
                     this["b" add a]._y = this.b1._y + (a - 1) * 15;
                     a2start = a2 + 1;
                     break;
                  }
                  if(a2 == 7)
                  {
                     this["b" add a].d = "off";
                     duplicateMovieClip(this.b1,"b" add a,16384 + a);
                     this["b" add a].t = "BACK";
                     this["b" add a]._y = this.b1._y + (a - 1) * 15;
                     backn = a;
                     a = 30;
                     if(a2start == 1)
                     {
                        this.b1.t = "no cheats";
                     }
                     break;
                  }
                  a2++;
               }
            }
            else if(this[current][a add "-type"] == "regler")
            {
               attachMovie("Menu_regler","b" add a,a);
               this["b" add a].reg._x = _root[this[current][a]] / 100 * 75 - 50;
               this["b" add a]._y = this.b1._y + (a - 1) * 15;
               this["b" add a]._x = this.b1._x;
            }
            else if(this[current][a add "-type"] == "eingabe")
            {
               attachMovie("Menu_eingabe","b" add a,a);
               this["b" add a].t = this[current][a].toUpperCase();
               this["b" add a]._y = this.b1._y + (a - 1) * 15;
               this["b" add a]._x = this.b1._x;
            }
            else if(current == "chara")
            {
               this["b" add a].d = "off";
               duplicateMovieClip(this.b1,"b" add a,16384 + a);
               if(a == 5)
               {
                  if(_root.unlock[1] == 1)
                  {
                     this["b" add a].t = this[current][a].toUpperCase();
                  }
                  else
                  {
                     this["b" add a].t = " ";
                  }
               }
               else if(a == 6)
               {
                  if(_root.unlock[2] == 1)
                  {
                     this["b" add a].t = this[current][a].toUpperCase();
                  }
                  else
                  {
                     this["b" add a].t = " ";
                  }
               }
               else
               {
                  this["b" add a].t = this[current][a].toUpperCase();
               }
               this["b" add a]._y = this.b1._y + (a - 1) * 15;
            }
            else
            {
               this["b" add a].d = "off";
               duplicateMovieClip(this.b1,"b" add a,16384 + a);
               this["b" add a].t = this[current][a].toUpperCase();
               this["b" add a]._y = this.b1._y + (a - 1) * 15;
            }
         }
         else
         {
            this["b" add a].removeMovieClip();
         }
         a++;
      }
   }
   tsx = _root.title._x;
   tsy = _root.title._y;
   chx = 500;
   current2 = "main";
}
