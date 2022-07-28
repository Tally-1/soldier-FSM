// This file contains settings and global variables that I do not want the end-user to touch.

missionNamespace setVariable ["SFSM_Battles",         createHashmap, true];
missionNamespace setVariable ["SFSM_debugMarkers",    [],            true];
missionNamespace setVariable ["SFSM_TaskCycleTimer",  10, 	         true];
missionNamespace setVariable ["SFSM_TestMode", 		  false, 	     true];
missionNamespace setVariable ["SFSM_customEH_Timer",  0.2, 	         true];


//variables used in the sound reaction function
SFSM_lastShotFired  = -300;
SFSM_lastSoundCheck = -300;

//How often the battlefield-data is updated
SFSM_BattleUpdateSec = 10;

//types of trees, simple way of distinguishing between hard and soft cover
SFSM_treeTypes = [
					"t_ficusb1s_f",
					"b_ficusc1s_f",
					"t_pinuss1s_f",
					"t_pinuss2s_b_f",
					"t_pinuss2s_f",
					"t_phoenixc1s_f",
					"b_ficusc2s_f",
					"b_neriumo2s_f",
					"t_populusn3s_f",
					"b_neriumo2s_white_f",
					"t_phoenixc3s_f",
					"t_ficusb2s_f",
					"t_oleae1s_f"
				];

//deactivate group-reset on vehicle FSM
if(!isNil "DCOnoGroupReset")
then{
		missionNamespace setVariable ["DCOnoGroupReset", true, true];
		"DCO soldier FSM deactivated group-reset for DCO vehicle FSM" call dbgmsg;
	};

//make sure the version-var is declared in case it has not loaded yet 
//(there is a difference between the load-order when developing and running the finished mod).
if(isNil "SFSM_Version")then{missionNamespace setVariable ["SFSM_Version", 0.293]};