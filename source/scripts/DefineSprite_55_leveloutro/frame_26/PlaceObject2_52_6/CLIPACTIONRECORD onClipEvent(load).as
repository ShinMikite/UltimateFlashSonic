onClipEvent(load){
   stat = 1;
   set("../:ringbonus",_root.rings * 10);
   if(_root.boss == "on")
   {
      set("../:timebonus",Math.round(_root.act[_root.czone add "-bosstime"] - (_root.time.min / 60 + _root.time.sec)) * 100);
   }
   else
   {
      set("../:timebonus",Math.round(_root.act[_root.czone add "-" add _root.cact add "-time"] - (_root.time.min / 60 + _root.time.sec)) * 100);
   }
   if(eval("../:timebonus") < 0)
   {
      set("../:timebonus",0);
   }
   sname = new Array();
   sname[1] = "ringbonus";
   sname[2] = "timebonus";
   sname[3] = "score";
   var a = 1;
   while(3 >= a)
   {
      if(a != 1)
      {
         duplicateMovieClip(eval("../:s1"),"s" add a,16384 + a);
      }
      _root.leveloutro["s" add a].s = sname[this.a];
      _root.leveloutro["s" add a]._x = 500 + a * 100;
      _root.leveloutro["s" add a]._y = _root.leveloutro.s1._y + (a - 1) * 20;
      a++;
   }
}
