//sleep 1;

//Set default settings unless previously defined
if(isNil "SFSM_FlinchTreshHold")
then{
		SFSM_Version			= 0.1;	//The current build version, not a setting.

		SFSM_FlinchTreshHold 	= 0.5;	//unit will not flinch if suppression is higher than this value
		SFSM_ProneTreshHold 	= 0.5;	//unit will stay prone if suppression is higher than this value
		SFSM_FlinchCoolDown		= 5;	//Minimum Time between each flinch-response
		SFSM_RpsDodgeTrigger	= 6;	//Continous Incoming bullets with no less than 1 second break, to trigger Dodging
		SFSM_DodgeCoolDown		= 10;	//Time between each dodge-response
		SFSM_DodgeDistance		= 20;	//How far the man will run when dodging
		SFSM_DodgeTimer			= 10;	//max time before ending a dodge.
		SFSM_forceDodge			= true; //OVerride the Vanilla FSM in order to force the unit to move when dodging
		SFSM_TaskCycleTimer		= 10; 	//Time beteen each iteration of the Task-manager
		SFSM_Debugger			= true; //show debug-info, and 3D markers
		SFSM_TestMode			= false;//Use 'firedNear' eventHandler to simulate incoming fire (usefull for testing)
};

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


{[_x] call Tally_Fnc_SFSM_InitMan} forEach allUnits;
[] spawn Tally_Fnc_SFSM_TaskManager;

diag_log "**soldier FSM server loaded**";