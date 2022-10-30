//--------comment by papaReap----------
/*
*  fn_serverInit.sqf
*  SFSM_fnc_serverInit

    do hc test here, if hc exists it will run scripts, if not Server will.
    I will be using my fn_hcTracker.sqf to accomplish this for the time being
    if hc gets disconnected we need to have server run these to take command.
    Note only 1 hc can be used for the moment!!!
	*papaReap*
*/


/*----------------papaReaps code--------------*/
private _hcPresent = false;

waitUntil { ( !(isNil "SFSM_HcCheckComplete") && { !(isNil "SFSM_Use_HC") } && { !(isNil "SFSM_HeadlessClients") } ) };


if ( !(isNil "HC") && { !(isNull HC) } && { SFSM_Use_HC } ) then {
    if (isServer) exitWith { diag_log "***soldier FSM * server exited***"; _hcPresent = true; };
    if ( !hasInterface && {!isServer} ) exitWith { diag_log "***soldier FSM * Headless Client Loaded***"; };
} else {
    diag_log "***soldier FSM * no HC active***";
};

if (isServer && {_hcPresent}) exitWith { [] call SFSM_fnc_initSettings; };

/*----------------papaReaps code end--------------*/


[] call SFSM_fnc_initSettings;
[] call SFSM_fnc_postConfig;



{[_x] call SFSM_fnc_InitMan} 	forEach allUnits;
{[_x] call SFSM_fnc_InitGroup} 	forEach allGroups;
{[_x] call SFSM_fnc_initVehicle}forEach vehicles;
{_x   call SFSM_fnc_curatorEH}  forEach allCurators;


[] spawn SFSM_fnc_TaskManager;
[] call  SFSM_fnc_unitKilled; 
[] call SFSM_fnc_unitCreated;

addMissionEventHandler ["BuildingChanged", {
	params ["_from", "_to", "_isRuin"];
    ["Building changed!", 2] call dbgmsg;

}];

/* --------comment by Tally----------
unitKilled and unitCreated are mission eventhandlers.
MissionEventHandlers only execute locally hence
whatever code is ran by them should be remoted to the HC if present.

This can be done dynamically by getting the owner of the unit and 
using remoteExec on the netId, if the netId is the server then the
function will execute as normal, if not then the function will be executed by
the HC.
*/


diag_log "***soldier FSM * server loaded***";




[] call SFSM_fnc_logSettings;