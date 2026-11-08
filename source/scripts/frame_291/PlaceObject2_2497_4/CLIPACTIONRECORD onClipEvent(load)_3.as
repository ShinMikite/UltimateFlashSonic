onClipEvent(load){
   function change(to, button)
   {
      _root.fx.fx("select");
      last[lastN] = current;
      lastN += 1;
      current2 = to;
      but = button;
      this["b" add but].t = "";
      _root.title.t = this[current][but].toUpperCase();
      _root.title.z = 1;
      _root.title._x = this["b" add but]._x;
      _root.title._y = this["b" add but]._y;
   }
   function back(button)
   {
      _root.fx.fx("back");
      lastN -= 1;
      current2 = last[lastN];
      but = button;
      if(current == "cheats")
      {
         _root.title.t = this["b" add but].t;
      }
      else
      {
         _root.title.t = this[current][but].toUpperCase();
      }
      _root.title.z = 1;
      _root.title._x = this["b" add but]._x;
      _root.title._y = this["b" add but]._y;
      this["b" add but].t = "";
   }
   function mainf()
   {
      if(this.b1.d == "on")
      {
         change("start",1);
      }
      else if(this.b2.d == "on")
      {
         change("options",2);
      }
      else if(this.b3.d == "on")
      {
         change("password",3);
      }
      else if(this.b4.d == "on")
      {
         change("cheats",4);
      }
   }
   function startf()
   {
      if(this.b1.d == "on")
      {
         _root.mode = "main";
         change("chara",1);
      }
      else if(this.b2.d == "on")
      {
         _root.mode = "timetrial";
         change("timetrial",2);
      }
      else if(this.b3.d == "on")
      {
         back(3);
      }
   }
   function passwordf()
   {
      if(this.b1.d == "on")
      {
         change("setpasswd",1);
      }
      else if(this.b2.d == "on")
      {
         change("getpasswd",2);
      }
      else if(this.b3.d == "on")
      {
         back(3);
      }
   }
   function getpasswdf()
   {
      this.b2.t = _root.getpasswd();
      if(this.b4.d == "on")
      {
         back(4);
      }
   }
   function setpasswdf()
   {
      if(this.b4.d == "on")
      {
         pass = new Array();
         passn = "2";
         passw = "invalid passwd";
         if(this["b" add passn].t.toLowerCase() == "dennis_gid")
         {
            _root.attachMovie("easteregg","easteregg","100");
         }
         else if(this["b" add passn].t.length < 15)
         {
            this["b" add passn].t = passw;
         }
         else
         {
            this["b" add passn].t = this["b" add passn].t.toString();
            pass[1] = Number(this["b" add passn].t.charAt(0) add this["b" add passn].t.charAt(1) add this["b" add passn].t.charAt(2));
            pass[2] = Number(this["b" add passn].t.charAt(3) add this["b" add passn].t.charAt(4));
            pass[3] = Number(this["b" add passn].t.charAt(5) add this["b" add passn].t.charAt(6));
            pass[4] = Number(this["b" add passn].t.charAt(7) add this["b" add passn].t.charAt(8));
            pass[5] = Number(this["b" add passn].t.charAt(9) add this["b" add passn].t.charAt(10));
            pass[6] = Number(this["b" add passn].t.charAt(11) add this["b" add passn].t.charAt(12));
            pass[7] = Number(this["b" add passn].t.charAt(13) add this["b" add passn].t.charAt(14));
            passcheck = Math.floor((pass[2] + pass[3] + pass[4] + pass[5] + pass[6] + pass[7]) * 3.2);
            while(passcheck >= 1000)
            {
               passcheck = Math.floor(passcheck / 10);
            }
            if(pass[1] == passcheck)
            {
               this["b" add passn].t = "accepted";
               var a = 2;
               while(7 >= a)
               {
                  if(pass[a] < 10)
                  {
                     pass[a] = "0" add pass[a];
                  }
                  a++;
               }
               _root.save.sonic = pass[2].toString();
               _root.save.tails = pass[3].toString();
               _root.save.knuckles = pass[4].toString();
               _root.save.cream = pass[5].toString();
               _root.save.amy = pass[6].toString();
               _root.save.shadow = pass[7].toString();
               _root.chara = "sonic";
               _root.setcheats();
            }
            else
            {
               this["b" add passn].t = passw;
            }
         }
         this.b4.d = "off";
      }
      else if(this.b5.d == "on")
      {
         back(5);
      }
   }
   function timetrialf()
   {
      if(this.b1.d == "on")
      {
         change("chara",1);
      }
      else if(this.b2.d == "on")
      {
         gotoframe = "records";
         _root.character.character.play();
      }
      else if(this.b3.d == "on")
      {
         back(3);
      }
   }
   function cheatsf()
   {
      var a = 2;
      while(10 >= a)
      {
         if(a == backn)
         {
            if(this["b" add a].d == "on")
            {
               back(backn);
            }
         }
         else
         {
            if(this["b" add a].d == "on")
            {
               if(_root.cheat[this["b" add a].cn] == 1)
               {
                  _root.cheat[this["b" add a].cn] = 2;
               }
               else
               {
                  _root.cheat[this["b" add a].cn] = 1;
               }
               this["b" add a].d = "off";
            }
            this["b" add a].t = _root.cheat[this["b" add a].cn add "-name"];
            if(_root.cheat[this["b" add a].cn] == 1)
            {
               this["b" add a].t = (this["b" add a].t add ": off").toUpperCase();
            }
            else if(_root.cheat[this["b" add a].cn] == 2)
            {
               this["b" add a].t = (this["b" add a].t add ": on").toUpperCase();
            }
         }
         a++;
      }
   }
   function charaf()
   {
      if(this.b1.d == "on")
      {
         if(_root.character.character._currentframe == 1)
         {
            _root.chara = "sonic";
         }
      }
      else if(this.b2.d == "on")
      {
         if(_root.character.character._currentframe == 1)
         {
            _root.chara = "tails";
         }
      }
      else if(this.b3.d == "on")
      {
         if(_root.character.character._currentframe == 1)
         {
            _root.chara = "knuckles";
         }
      }
      else if(this.b4.d == "on")
      {
         if(_root.character.character._currentframe == 1)
         {
            _root.chara = "cream";
         }
      }
      else if(this.b5.d == "on" && this.b5.t != " ")
      {
         if(_root.character.character._currentframe == 1)
         {
            _root.chara = "amy";
         }
      }
      else if(this.b6.d == "on" && this.b5.t != " ")
      {
         if(_root.character.character._currentframe == 1)
         {
            _root.chara = "shadow";
         }
      }
      else if(this.b7.d == "on")
      {
         _root.character.character.play();
      }
      else if(this.b8.d == "on")
      {
         back(8);
      }
   }
   function optionsf()
   {
      _root.FXvol = this.b2.val;
      _root.musicvol = this.b4.val;
      if(this.b2.reg.d == "on")
      {
         if(5 < count)
         {
            _root.fx.fx("select");
            count = 0;
         }
         else
         {
            count++;
         }
      }
      else if(this.b6.d == "on")
      {
         back(6);
      }
   }
}
