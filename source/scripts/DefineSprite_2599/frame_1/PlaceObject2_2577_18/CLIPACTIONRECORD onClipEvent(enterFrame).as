onClipEvent(enterFrame){
   max = 6;
   t = "";
   var a = 1;
   while(max >= a)
   {
      if(_root.score < Math.pow(10,a))
      {
         t = t add "0";
      }
      a++;
   }
   t = t add _root.score;
   this.t1 = t;
   this.t2 = t;
   this.t3 = t;
   this.t4 = t;
}
