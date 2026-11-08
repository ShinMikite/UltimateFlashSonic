message = new Array();
message[1] = "works only with sonic";
message[2] = "doesn\'t work with tails";
message[3] = "";
message[4] = "works only with cream";
message[5] = "";
message[6] = "";
if(_root.chara == "sonic")
{
   num = 1;
}
else if(_root.chara == "tails")
{
   num = 2;
}
else if(_root.chara == "knuckles")
{
   num = 3;
}
else if(_root.chara == "cream")
{
   num = 4;
}
else if(_root.chara == "amy")
{
   num = 5;
}
else if(_root.chara == "shadow")
{
   num = 6;
}
if(_root.zones < Number(_root.save.sonic.charAt(0)) && _root.zones < Number(_root.save.tails.charAt(0)))
{
   if(_root.zones < Number(_root.save.knuckles.charAt(0)) && _root.zones < Number(_root.save.cream.charAt(0)))
   {
      if(_root.unlock[1] == 0)
      {
         messagefin = "NEW CHARACTER: Amy Rose\n";
      }
   }
}
if(num == 5)
{
   if(_root.unlock[2] == 0)
   {
      messagefin = "NEW CHARACTER: Shadow\n";
   }
   if(_root.unlock[3] == 0)
   {
      messagefin = messagefin add "JUKEBOX unlocked:\n";
      messagefin = messagefin add "select your favorite\ntrack while pause";
   }
}
else if(num == 6)
{
   messagefin = messagefin add "CONGRATULATIONS\nYou\'ve completed the\nwhole game!!";
}
else if(_root.cheat[num] == 0)
{
   messagefin = messagefin add "NEW CHEAT: " add _root.cheat[num add "-name"] add "\n" add message[num];
}
