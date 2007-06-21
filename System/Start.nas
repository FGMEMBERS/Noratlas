#====================================================================================
Starter = func { 		
	
	setprop("controls/engines/engine[0]/starter",1);
	setprop("controls/engines/engine[0]/throttle",0.30);
	setprop("controls/engines/engine[1]/starter",1);
	setprop("controls/engines/engine[2]/starter",1);
	setprop("controls/engines/engine[3]/starter",1);
	setprop("controls/engines/engine[1]/throttle",0.30);
}
Starter_end = func { 	
	setprop("controls/engines/engine[0]/starter",0);
	setprop("controls/engines/engine[0]/throttle",0.20);
	setprop("controls/engines/engine[1]/starter",0);
	setprop("controls/engines/engine[2]/starter",0);
	setprop("controls/engines/engine[3]/starter",0);
	setprop("controls/engines/engine[1]/throttle",0.20);
	
}

#Control Moteur  "Engine Master"==============================

setprop("/controls/switches/delay",0 );
setprop("/controls/engines/engine[2]/fuel-pump",0);
setprop("/controls/engines/engine[3]/fuel-pump",0);
Cutoff_Cmd=func{	
	setprop("/controls/switches/delay",0 );
	setprop("controls/engines/engine[2]/throttle",0);
        setprop("controls/engines/engine[3]/throttle",0);
	if(getprop("/controls/engines/engine[2]/fuel-pump")==1){
		setprop("/controls/engines/engine[2]/cutoff",1);
		setprop("/controls/engines/engine[2]/fuel-pump",0);
        }        
        if(getprop("/controls/engines/engine[3]/fuel-pump")==1){
		setprop("/controls/engines/engine[3]/cutoff",1);
		setprop("/controls/engines/engine[3]/fuel-pump",0);
		
	}else{
	Eng_Master_On();	
	}
}	
	
Eng_Master_On=func{
		setprop("/controls/engines/engine[2]/fuel-pump",1);
                setprop("/controls/engines/engine[3]/fuel-pump",1);
		interpolate("/controls/switches/delay",5,1 );
		if (getprop("/controls/switches/delay")==5){
			setprop("/controls/engines/engine[2]/cutoff",0);
                        setprop("/controls/engines/engine[3]/cutoff",0);
		}else{
		settimer(Eng_Master_On,1);
		}	
}


#Alimentation Electrique========Allumé   Coupé===========================================


Aig_AC=0;
setprop("/controls/electric/master-switch",Aig_AC);

Electric_Cmt=func{
	Aig_AC=getprop("/controls/electric/master-switch");
	Aig_AC=1-Aig_AC;
	setprop("/controls/electric/master-switch",Aig_AC);
}

Electric_Cmd=func{
	if(getprop("/controls/electric/master-switch")=="1"){
	setprop("/controls/electric/battery-switch","true");
	setprop("controls/electric/external-power", "true");
	setprop("/controls/engines/engine[0]/master-bat", "true");
	setprop("/controls/engines/engine[1]/master-bat", "true");
        
    	setprop("/controls/switches/master-avionics", "true");	
	}
	elsif(getprop("/controls/electric/master-switch")=="0"){
	setprop("/controls/electric/battery-switch","false");
	setprop("controls/electric/external-power", "false");
	setprop("/controls/engines/engine[0]/master-bat", "false");
	setprop("/controls/engines/engine[1]/master-bat", "false");
        
    	setprop("/controls/switches/master-avionics", "false");
	setprop("/controls/lighting/instruments-norm",0);
	}
}
Electric_Cmd();

setlistener("/controls/electric/master-switch",Electric_Cmd);



#init  Alimentation Electrique====Départ moteur tournant=============

Electric_Init=func{
            setprop("/controls/electric/master-switch",1);
            setprop("/controls/engines/engine[0]/master-bat", "true");
            setprop("/controls/engines/engine[1]/master-bat", "true");
            setprop("/controls/electric/battery-switch","true");
            setprop("controls/electric/external-power", "true");
    }
    
#Electric_Init();
