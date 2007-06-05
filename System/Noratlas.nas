#control  des  parachutistes


Parachuter_Cmd=func{
                 if (getprop("fdm/jsbsim/fcs/ar-latg-porte-pos-norm") == 1) {
                 setprop("/controls/jump-signal",1);
                  }
}