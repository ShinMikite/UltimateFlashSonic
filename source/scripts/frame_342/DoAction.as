stop();
_root.pause = 0;
var a = 1;
while(_root.lrtotal >= a)
{
   _root["rl" add a].removeMovieClip();
   a++;
}
var a = 1;
while(_root.objtotal >= a)
{
   _root["obj" add a].removeMovieClip();
   a++;
}
_root.Level.removeMovieClip();
_root.Level2.removeMovieClip();
_root.levelo.removeMovieClip();
_root.levelo2.removeMovieClip();
_root.Sonic1.removeMovieClip();
_root.hud.removeMovieClip();
_root.leveloutro.removeMovieClip();
_root.cheese.removeMovieClip();
_root.bossobj.removeMovieClip();
_root.pausescreen.removeMovieClip();
_root.gameover.removeMovieClip();
if(!(_root.boss == "on" || _root.quit == "on" || _root.restart == "on"))
{
   ctime = Number(_root.time.min add _root.time.sec add _root.time.hun);
   rtime = _root.record[_root.czone add "-" add _root.cact].split(":");
   rtime = Number(_root.rtime[0] add _root.rtime[1] add _root.rtime[2]);
   if(ctime < rtime)
   {
      _root.record[_root.czone add "-" add _root.cact] = _root.time.min add ":" add _root.time.sec add ":" add _root.time.hun;
      _root.record[_root.czone add "-" add _root.cact add "-char"] = _root.chara;
   }
   delete rtime;
   delete ctime;
}
if(_root.quit == "on")
{
   _root.boss = "off";
   _root.quit = "off";
   gotoAndStop(291);
}
else if(_root.restart == "on")
{
   _root.restart = "off";
   if(_root.mode == "main")
   {
      gotoAndStop(327);
   }
   else
   {
      gotoAndStop(314);
   }
}
else if(_root.mode == "timetrial")
{
   gotoAndStop(314);
}
else if(_root.mode == "main")
{
   if(boss == "on")
   {
      _root.boss = "off";
      if(_root.czone >= Number(_root.save[_root.chara].charAt(0)))
      {
         _root.save[_root.chara] = _root.czone + 1 add "1";
      }
      if(_root.czone >= 2)
      {
         _root.attachMovie("End","End",50);
      }
      else
      {
         _root.czone += 1;
         _root.cact = 1;
         gotoAndStop(327);
      }
   }
   else
   {
      if(Number(_root.save[_root.chara].charAt(1)) < _root.cact && _root.czone >= Number(_root.save[_root.chara].charAt(0)))
      {
         _root.save[_root.chara] = _root.czone add _root.cact;
      }
      _root.cact += 1;
      if(2 < _root.cact)
      {
         _root.cact = 1;
         _root.boss = "on";
      }
      gotoAndStop(327);
   }
}
_root.resart = "off";
