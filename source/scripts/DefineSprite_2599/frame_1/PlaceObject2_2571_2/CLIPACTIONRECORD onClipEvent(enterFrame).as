onClipEvent(enterFrame){
   if(_root.Sonic1.fin == "off" && _root.pause == 0 && _root.boss != "on" || _root.boss == "on" && _root.bossstat == "alive" && _root.pause == 0)
   {
      hun = Math.round(Number(hun) + 2.857142857142857);
      if(Number(hun) >= 100)
      {
         sec = Number(sec) + 1;
         if(sec >= 60)
         {
            min += 1;
            sec = Number(sec) - 60;
         }
         else if(sec < 10)
         {
            sec = "0" add sec;
         }
         hun = Number(hun) - 100;
      }
      else if(Number(hun) < 10)
      {
         hun = "0" add hun;
      }
      _root.time.min = min;
      _root.time.sec = sec;
      _root.time.hun = hun;
      min2 = min;
      sec2 = sec;
      hun2 = hun;
      min3 = min;
      sec3 = sec;
      hun3 = hun;
   }
}
