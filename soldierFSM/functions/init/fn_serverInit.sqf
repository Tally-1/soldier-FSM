// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

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

// Tally: Will be updated in the post-config 
SFSM_aceLoaded = false;

/*----------------papaReaps code--------------*/
private _hcPresent = false;

waitUntil { ( !(isNil "PR_HC_CheckComplete") && { !(isNil "PR_HeadlessClients")  } ) };
publicVariable "PR_HC_CheckComplete";
publicVariable "PR_HeadlessClients";

if ( (count PR_HeadlessClients > 0) && { (!(isNil "PR_HC1")) } ) then {
    if (isServer) exitWith { diag_log "***soldier FSM * server exited, headless client used***"; _hcPresent = true; };
    if ( !hasInterface && {!isServer} ) exitWith { diag_log "***soldier FSM * Headless Client Loaded***"; };
} else {
    diag_log "***soldier FSM * no HC active***";
};

if (isServer && {_hcPresent}) exitWith { [] call SFSM_fnc_initSettings; };

/*----------------papaReaps code end--------------*/

// Forcing unscheduled call
// See leopard20s comment at the bottom of this page:
// https://community.bistudio.com/wiki/call
isNil{
    [] call SFSM_fnc_initSettings;
    [] call SFSM_fnc_postConfig;

    {[_x] call SFSM_fnc_InitMan}     forEach allUnits;
    {[_x] call SFSM_fnc_InitGroup}   forEach allGroups;
    {[_x] call SFSM_fnc_initVehicle} forEach vehicles;
    {_x   call SFSM_fnc_curatorEH}   forEach allCurators;
    []    call SFSM_fnc_initFIPOsAndAZs;
    []    call SFSM_fnc_unitKilled; 
    []    call SFSM_fnc_unitCreated;
    []    call SFSM_fnc_projectileCreated;
    []    call SFSM_fnc_buildingDestroyedEH;
    []    call SFSM_fnc_speechEventsMan;
    []    call SFSM_fnc_animationMaps;
    []    call SFSM_fnc_antiRubberBand;
    []    call SFSM_fnc_ACE_MedicalCBA;
    
};

sleep 0.1;

[] spawn SFSM_fnc_TaskManager;
[] spawn SFSM_fnc_fipoManager;
[] spawn SFSM_fnc_AZmanager;
// [] spawn SFSM_fnc_moraleUpdater;

/* --------comment by Tally----------
unitKilled and unitCreated are mission eventhandlers.
MissionEventHandlers only execute locally hence
whatever code is ran by them should be remoted to the HC if present.

This can be done dynamically by getting the owner of the unit and 
using remoteExec on the netId, if the netId is the server then the
function will execute as normal, if not then the function will be executed by
the HC.
*/

// this fnc is run locally, hence a global declaration is needed for those clients
// that does not have SFSM loaded
missionNamespace setVariable ["Tcore_fnc_setTextTexture",Tcore_fnc_setTextTexture, true];

diag_log "***soldier FSM * server loaded***";

// ["new_battle", {}] call CBA_fnc_addEventHandler;
[] call SFSM_fnc_logSettings;

//Making sure all VR indicators are deleted 
{if(_x getVariable ['fipo_ind', false])then{deleteVehicle _x}} forEach allUnits;