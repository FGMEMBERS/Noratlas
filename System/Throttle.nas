
#nous utilisons un "engine" dummy (engine[4]) pour  controler l'ensemble des "throttles"
#deux types de moteurs:
#--  piston qui sera incrémenté de 0.2 à 1, par calcul sur la base du dummy 0.2 à 0.8
#--  turbojet qui sera incrémenté de 0 à 1, par calcul sur la base du dummy de 0.8 à 1

# dummy   0<---------->0.2<--------------------------------------------------------->0.8<--------------------->1
# piston      0<---------->0.2<--------------------------------------------------------->1<----------------------->1
# turbojet   0<---------->0<----------------------------------------------------------->0<----------------------->1

throttlemaster=0;


Throttle_Cmd=func{
            throttlemaster=getprop("controls/engines/engine[4]/throttle");
           
          
            if (throttlemaster < 0.2) {
                setprop("controls/engines/engine[0]/throttle",0.2);
                setprop("controls/engines/engine[1]/throttle",0.2);
                }else {
                piston_throttle=((throttlemaster-0.2)*1.3334)+0.2;
                setprop("controls/engines/engine[0]/throttle",piston_throttle);
                setprop("controls/engines/engine[1]/throttle",piston_throttle);
                }
            if (throttlemaster > 0.8) {
                turbo_throttle=(throttlemaster-0.8)*5;
                setprop("controls/engines/engine[2]/throttle",turbo_throttle);
                setprop("controls/engines/engine[3]/throttle",turbo_throttle); 
                }else{
                setprop("controls/engines/engine[2]/throttle",0);
               setprop("controls/engines/engine[3]/throttle",0);
               }
}

   # setlistener("controls/engines/engine[4]/throttle",Throttle_Cmd);
    
    
    #Control surcompression et durée d'utilisation=========================================
 #// (In throttle % - actual input is 0 -> 1)
 #// 99 / 100 - Takeoff boost
 #// 96 / 97 / 98 - Rated boost
 #// 0 - 95 - Idle to Rated boost (MinManifoldPressure to MaxManifoldPressure)
 #// In real life, most planes would be fitted with a mechanical 'gate' between
 #// the rated boost and takeoff boost positions.

#TakeOffBoost=0.99;
#RatedBoost=0.96;
#IdleRatedBoostMin=0;
#IdleRatedBoostMax=0.95;

boost_start=0;
delay_st=300;  #5 minutes ?
timer_boost=0;
now_st=0;

Ctl_Throttle=func{
	if(getprop("/controls/engines/engine[0]throttle")>0.981 and getprop("/position/altitude-agl-ft")<100){
		if(timer_boost==1){	
			now_st=getprop("sim/time/elapsed-sec");			
			if (now_st - boost_start > delay_st ) {
				setprop("controls/engines/engine[0]throttle", 0.98);
                                setprop("controls/engines/engine[1]throttle", 0.98);
                                print("boost_stop");
				timer_boost=0;
				#print("now_st",now_st);
				#print("Fin",timer_boost);
			}
		}else{
			timer_boost=1;
			boost_start=getprop("sim/time/elapsed-sec");
			print("boost_start");
			}
		settimer(Ctl_Throttle,1);
	}else{
	timer_boost=0;
	#print("Fin",timer_boost);
	}
	#print("boucle");
	
}





setlistener("controls/engines/engine[0]throttle",Ctl_Throttle);
