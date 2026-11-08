function getpasswd()
{
   pass = new Array();
   pass[1] = _root.save.sonic;
   pass[2] = _root.save.tails;
   pass[3] = _root.save.knuckles;
   pass[4] = _root.save.cream;
   pass[5] = _root.save.amy;
   pass[6] = _root.save.shadow;
   passsum = 0;
   var a = 1;
   while(6 >= a)
   {
      passsum += Number(pass[a]);
      a++;
   }
   passsum = Math.floor(passsum * 3.2);
   if(passsum < 10)
   {
      passsum = "00" add passsum;
   }
   else if(passsum < 100)
   {
      passsum = "0" add passsum;
   }
   else
   {
      passsum = passsum.toString();
      passsum = passsum.charAt(0) add passsum.charAt(1) add passsum.charAt(2);
   }
   val = passsum;
   var a = 1;
   while(6 >= a)
   {
      val = val add pass[a];
      a++;
   }
   return val;
}
function setcheats()
{
   if(_root.zones < Number(_root.save.sonic.charAt(0)))
   {
      _root.cheat[1] = 1;
   }
   if(_root.zones < Number(_root.save.tails.charAt(0)))
   {
      _root.cheat[2] = 1;
   }
   if(_root.zones < Number(_root.save.knuckles.charAt(0)))
   {
      _root.cheat[3] = 1;
   }
   if(_root.zones < Number(_root.save.cream.charAt(0)))
   {
      _root.cheat[4] = 1;
   }
   if(_root.zones < Number(_root.save.amy.charAt(0)))
   {
      _root.cheat[5] = 1;
   }
   if(_root.zones < Number(_root.save.sonic.charAt(0)) && _root.zones < Number(_root.save.tails.charAt(0)))
   {
      if(_root.zones < Number(_root.save.knuckles.charAt(0)) && _root.zones < Number(_root.save.cream.charAt(0)))
      {
         unlock[1] = 1;
         if(_root.zones < Number(_root.save.amy.charAt(0)))
         {
            unlock[2] = 1;
            unlock[3] = 1;
         }
      }
   }
}
_root.musicvol = 100;
_root.FXvol = 100;
_root.chara = "sonic";
_root.record = new Array();
_root.scorev = new Array();
_root.scorev.enemy = 10;
var a = 1;
while(5 >= a)
{
   var a2 = 1;
   while(5 >= a2)
   {
      _root.record[a add "-" add a2] = "9:59:99";
      _root.record[a add "-" add a2 add "-char"] = "sonic";
      a2++;
   }
   a++;
}
_root.cheat = new Array();
var a = 1;
while(6 >= a)
{
   _root.cheat[a] = 0;
   a++;
}
_root.cheat["1-name"] = "sonic-run 2";
_root.cheat["2-name"] = "tails follow";
_root.cheat["3-name"] = "behind";
_root.cheat["4-name"] = "big-cheese";
_root.cheat["5-name"] = "moon";
_root.unlock = new Array();
_root.unlock[1] = 0;
_root.unlock[2] = 0;
_root.unlock[3] = 0;
_root.save = new Array();
_root.save.sonic = "01";
_root.save.tails = "01";
_root.save.knuckles = "01";
_root.save.cream = "01";
_root.save.amy = "01";
_root.save.shadow = "01";
_root.zone = new Array();
_root.act = new Array();
_root.bossn = new Array();
_root.bossn[1] = "spinning egg";
_root.bossn[2] = "egg bomber";
_root.czone = 1;
_root.cact = 1;
_root.zone[1] = "LEAF FOREST";
_root.act["1-bosstime"] = 120;
_root.act["1-1"] = "chill gardens";
_root.act["1-1-time"] = 60;
_root.act["1-2"] = "emerald forest";
_root.act["1-2-time"] = 70;
_root.zone[2] = "ICE PARADISE";
_root.act["2-bosstime"] = 120;
_root.act["2-1"] = "snowy mountain";
_root.act["2-1-time"] = 60;
_root.act["2-2"] = "frosty island";
_root.act["2-2-time"] = 70;
_root.act["3-1"] = "emerald coast";
_root.act["3-2"] = "green hill";
_root.zone[4] = "ENERGY PLANT";
_root.act["4-1"] = "powersource";
_root.act["4-2"] = "omega station";
_root.act["4-3"] = "omega station";
_root.act["4-4"] = "thunderstorm";
_root.act["4-5"] = "ultimate showdown";
_root.zone[5] = "RED MOUNTAIN";
_root.act["5-1"] = "windy valley";
_root.act["5-2"] = "mystic cave";
_root.zones = 2;
