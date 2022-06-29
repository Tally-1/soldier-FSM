//sleep 1;

//Set default settings unless previously defined
if(isNil "SFSM_FlinchTreshHold")
then{
		SFSM_Version			= 0.12;	//The current build version, not a setting.

		SFSM_FlinchTreshHold 	= 0.5;	//unit will not flinch if suppression is higher than this value
		SFSM_ProneTreshHold 	= 0.8;	//unit will stay prone if suppression is higher than this value
		SFSM_FlinchCoolDown		= 5;	//Minimum Time between each flinch-response
		SFSM_RpsDodgeTrigger	= 4;	//Continous Incoming bullets with no less than 1 second break, to trigger Dodging
		SFSM_DodgeCoolDown		= 10;	//Time between each dodge-response
		SFSM_DodgeDistance		= 40;	//How far the man will run when dodging
		SFSM_DodgeTimer			= 30;	//max time before ending a dodge.
		SFSM_forceDodge			= true; //Override the Vanilla FSM in order to force the unit to move when dodging
		SFSM_noCoverPanic       = true; // unit will panic upon initiating a battle if no cover is found
		SFSM_reactFireCoolDown	= 180; 	//Time between each returnFire-response
		SFSM_customEH_Timer     = 0.2;  //Iteration between every check (enemy spotted)
		
		SFSM_Debugger			= true; //show debug-info, and 3D markers
		
};

SFSM_TaskCycleTimer		= 10;
SFSM_TestMode			= false;//Use 'firedNear' eventHandler to simulate incoming fire (usefull for testing)

//Make sure settings are available globally.

missionNamespace setVariable ["SFSM_FlinchTreshHold",	SFSM_FlinchTreshHold, 	true];
missionNamespace setVariable ["SFSM_ProneTreshHold", 	SFSM_ProneTreshHold, 	true];
missionNamespace setVariable ["SFSM_FlinchCoolDown", 	SFSM_FlinchCoolDown, 	true];
missionNamespace setVariable ["SFSM_RpsDodgeTrigger", 	SFSM_RpsDodgeTrigger, 	true];
missionNamespace setVariable ["SFSM_DodgeCoolDown", 	SFSM_DodgeCoolDown, 	true];
missionNamespace setVariable ["SFSM_DodgeDistance", 	SFSM_DodgeDistance, 	true];
missionNamespace setVariable ["SFSM_DodgeTimer", 		SFSM_DodgeTimer, 		true];
missionNamespace setVariable ["SFSM_TaskCycleTimer", 	SFSM_TaskCycleTimer, 	true];
missionNamespace setVariable ["SFSM_Debugger", 			SFSM_Debugger, 			true];
missionNamespace setVariable ["SFSM_TestMode", 			SFSM_TestMode, 			true];


{[_x] call SFSM_fnc_InitMan} 	forEach allUnits;
{[_x] call SFSM_fnc_InitGroup} 	forEach allGroups;
{_x   call SFSM_fnc_curatorEH}  forEach allCurators;

//PostConfig init ***!!!DO NOT CHANGE!!***
missionNamespace setVariable ["SFSM_Battles",         createHashmap, true];
missionNamespace setVariable ["SFSM_debugMarkers",    [], true];
SFSM_lastShotFired  = -300;
SFSM_lastSoundCheck = -300;
SFSM_BattleUpdateSec = 10;
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


[] spawn SFSM_fnc_TaskManager;
[] spawn SFSM_fnc_spottedCustomEH;



diag_log "***soldier FSM * server loaded***";

sleep 1;

if(!isNil "DCOnoGroupReset")then{missionNamespace setVariable ["DCOnoGroupReset", true, true]};