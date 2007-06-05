
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

    setlistener("controls/engines/engine[4]/throttle",Throttle_Cmd);