//sleep 1;

//Set default settings unless previously defined
if(isNil "SFSM_FlinchTreshHold")
then{
		SFSM_disableSoldierFSM  = false; // disable soldier FSM
		SFSM_Debugger			= true; // show debug-info, and 3D markers
		SFSM_allowFlinching     = true;  // Units will flinch on incoming fire.
		SFSM_allowDodging       = true;  // Units will dodge(change position) when incoming fire reaches the treshHold (SFSM_RpsDodgeTrigger).
		SFSM_hideFromVehicles   = true;  // Units will run away / hide from vehicles they cannot hurt.
		SFSM_AtSpecHuntVehicles = true;  // Units with launchers will target enemy vehicles instead of hiding.
        SFSM_mgSuppressClusters = true;  // MachineGunners will spray enemy positions upon initial contact
		SFSM_enableCustomEH     = true;  // disable custom eventhandler for enemy-spotted. Deactivating this is VERY good for performance.
		SFSM_ExcludeZcommand    = true;  // stop units that have been given waypoints by a curator from dodging
		SFSM_PlayerGrpDodge     = false; // Allows units in a group lead by a player to dodge / hide, dodging can be frustrating for players who like to micro-manage their AI

		SFSM_FlinchTreshHold 	= 0.5;	 // unit will not flinch if suppression is higher than this value
		SFSM_ProneTreshHold 	= 0.8;	 // unit will stay prone if suppression is higher than this value
		SFSM_FlinchCoolDown		= 5;	 // Minimum Time between each flinch-response
		SFSM_RpsDodgeTrigger	= 4;	 // Continous Incoming bullets with no less than 1 second break, to trigger Dodging
		SFSM_DodgeCoolDown		= 10;	 // Time between each dodge-response
		SFSM_DodgeDistance		= 40;	 // How far the man will run when dodging
		SFSM_DodgeTimer			= 30;	 // max time before ending a dodge.
		SFSM_forceDodge			= true;  // Override the Vanilla FSM in order to force the unit to move when dodging
		SFSM_noCoverPanic       = true;  // unit will panic upon initiating a battle if no cover is found
		SFSM_reactFireCoolDown	= 180; 	 // Time between each returnFire-response		
};


//Make sure settings are available globally.

missionNamespace setVariable ["SFSM_FlinchTreshHold",	SFSM_FlinchTreshHold, 	true];
missionNamespace setVariable ["SFSM_ProneTreshHold", 	SFSM_ProneTreshHold, 	true];
missionNamespace setVariable ["SFSM_FlinchCoolDown", 	SFSM_FlinchCoolDown, 	true];
missionNamespace setVariable ["SFSM_RpsDodgeTrigger", 	SFSM_RpsDodgeTrigger, 	true];
missionNamespace setVariable ["SFSM_DodgeCoolDown", 	SFSM_DodgeCoolDown, 	true];
missionNamespace setVariable ["SFSM_DodgeDistance", 	SFSM_DodgeDistance, 	true];
missionNamespace setVariable ["SFSM_DodgeTimer", 		SFSM_DodgeTimer, 		true];
missionNamespace setVariable ["SFSM_forceDodge", 		SFSM_forceDodge, 		true]; 
 
missionNamespace setVariable ["SFSM_Debugger", 			SFSM_Debugger, 			true]; 
missionNamespace setVariable ["SFSM_noCoverPanic", 		SFSM_noCoverPanic, 		true];
missionNamespace setVariable ["SFSM_reactFireCoolDown", SFSM_reactFireCoolDown, true];
missionNamespace setVariable ["SFSM_ExcludeZcommand", 	SFSM_ExcludeZcommand, 	true];
missionNamespace setVariable ["SFSM_PlayerGrpDodge", 	SFSM_PlayerGrpDodge, 	true];
missionNamespace setVariable ["SFSM_hideFromVehicles", 	SFSM_hideFromVehicles, 	true];
missionNamespace setVariable ["SFSM_AtSpecHuntVehicles",SFSM_AtSpecHuntVehicles,true];
missionNamespace setVariable ["SFSM_mgSuppressClusters",SFSM_mgSuppressClusters,true];
missionNamespace setVariable ["SFSM_disableSoldierFSM", SFSM_disableSoldierFSM, true];
missionNamespace setVariable ["SFSM_enableCustomEH",    SFSM_enableCustomEH,    true];
missionNamespace setVariable ["SFSM_allowFlinching",    SFSM_allowFlinching,    true];
missionNamespace setVariable ["SFSM_allowDodging",      SFSM_allowDodging,      true];







//PostConfig init ***!!!DO NOT CHANGE!!***
missionNamespace setVariable ["SFSM_Battles",         createHashmap, true];
missionNamespace setVariable ["SFSM_debugMarkers",    [],            true];
missionNamespace setVariable ["SFSM_TaskCycleTimer",  10, 	         true];
missionNamespace setVariable ["SFSM_TestMode", 		  false, 	     true];
missionNamespace setVariable ["SFSM_customEH_Timer",  0.2, 	         true];

if(isNil "SFSM_Version")then{missionNamespace setVariable ["SFSM_Version", 0.291]};

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


{[_x] call SFSM_fnc_InitMan} 	forEach allUnits;
{[_x] call SFSM_fnc_InitGroup} 	forEach allGroups;
{_x   call SFSM_fnc_curatorEH}  forEach allCurators;

[] spawn SFSM_fnc_TaskManager;
[] spawn SFSM_fnc_spottedCustomEH;



diag_log "***soldier FSM * server loaded***";

sleep 1;

if(!isNil "DCOnoGroupReset")
then{
		missionNamespace setVariable ["DCOnoGroupReset", true, true];
		"DCO soldier FSM deactivated group-reset for DCO vehicle FSM" call dbgmsg;
	};

//this block could probably have been simplified a lot by writing a function for this specific purpose,
//However for now I'll leave it like this and clean up later.

[["Debugger ", SFSM_Debugger],                            SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["Flinching ", SFSM_allowFlinching],                     SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["Dodging ", SFSM_allowDodging],                         SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["Hiding ", SFSM_hideFromVehicles],                      SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["Hunt Vehicles ", SFSM_AtSpecHuntVehicles],             SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["MG suppress clusters ", SFSM_mgSuppressClusters],      SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["Custom EH ", SFSM_enableCustomEH],                     SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["Exclude Zeus commanded units ", SFSM_ExcludeZcommand], SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["Player group dodge ", SFSM_PlayerGrpDodge],            SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["flinchTreshHold ", SFSM_FlinchTreshHold],              SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["flinchCoolDown ", SFSM_FlinchCoolDown],                SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["prone-treshHold ", SFSM_ProneTreshHold],               SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["dodge Trigger ", SFSM_RpsDodgeTrigger],                SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["dodge-CoolDown ", SFSM_DodgeCoolDown],                 SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["dodge-distance ", SFSM_DodgeDistance],                 SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["dodge-timer ", SFSM_DodgeTimer],                       SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["force-dodge ", SFSM_forceDodge],                       SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["no-Cover-Panic ", SFSM_noCoverPanic],                  SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;
[["react-fire coolDown ", SFSM_reactFireCoolDown],        SFSM_Debugger, true, 1, "Soldier FSM init settings --->"] call Tcore_fnc_debugMessage;