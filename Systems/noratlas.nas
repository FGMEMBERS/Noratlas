
#controle permanent=======================================================


#Cutoff géré globalement par =========jsbsim/fcs/cutoff-switch========voir le FDM
Update_engine=func{ 
                var cutoff2 =0;
                var cutoff3 =0;
                if (getprop("/controls/engines/engine[2]/cutoff-cmd")) { cutoff2 =1; }
                if (getprop("/controls/engines/engine[3]/cutoff-cmd")) { cutoff3=1; }
                #==place pour d'autres causes de cutoff======
                setprop("/controls/engines/engine[2]/cutoff",cutoff2);
                setprop("/controls/engines/engine[3]/cutoff",cutoff3);
        }
#==============================================

#==============================================
Loop_update_noratlas=func{
                Update_engine();
                settimer ( Loop_update_noratlas, 2 );
                }
Loop_update_noratlas();
#==============================================

