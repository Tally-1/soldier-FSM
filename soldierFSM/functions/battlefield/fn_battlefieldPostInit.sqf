//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: called by SFSM_fnc_initBattlefield, this function initializes the battlefield and all units in it. It also spawns a loop that updates the battlefield-hashmap every 10 seconds.

// Params: [_battlefield] (hashmap)

// Return value: true

// Example: [_battlefield] spawn SFSM_fnc_battlefieldPostInit;

params["_battlefield"];
_battlefield set ["currentAction", "Waiting for grid to load"];

//wait for grid to load, so that actions like hiding may be properly executed
private _timer = time +5;
waitUntil
{
    sleep 0.1;
    private _gridLoaded = (_battlefield get "gridLoaded");
    if(isNil "_gridLoaded")    exitWith{true};
    if(_gridLoaded)            exitWith{true};
    if(_timer > time)          exitWith{true};
    false;
};

_battlefield set ["currentAction",    "Waiting to initialize vehicles"];
private _vehicles = missionNamespace getVariable (_battlefield get "vehicles");
{[_x] call SFSM_fnc_updateVehicle;}forEach _vehicles;
//loop through all units in the battle assigning start-battle actions.

_battlefield set ["currentAction",    "Executing initial BFF actions"];
private _units = missionNamespace getVariable (_battlefield get "units");
{[]spawn{isNil{
    private _group          = group _x;
    private _specialActions = [_x, _battlefield] call SFSM_fnc_specialInitFightActions;
    private _grpCanDodge    = ([_group] call SFSM_fnc_groupCanDodge);
    private _excluded       = _x getVariable ["SFSM_Excluded",false];
    if(_grpCanDodge
    &&{(_specialActions isEqualTo false)
    &&{_excluded        isEqualTo false}})
    then{
            private _reacting = [_x, _battleField] call SFSM_fnc_reactToVehicles;
            if!(_reacting)then{ [_x, _battlefield] call SFSM_fnc_fightInitCover;};
        };

}}} forEach _units;

_battlefield set ["currentAction",    "Waiting for terrain to load"];
sleep 1;

//wait for the battlefield framework to register all map-objects in the area
waitUntil
{
    sleep 0.5;
    private _terrainLoaded = (_battlefield get "terrainLoaded");
    if(isNil "_terrainLoaded")    exitWith{true};
    if(_terrainLoaded)            exitWith{true};
    false;
};

//update cover-positions
if(SFSM_simpleBff isEqualTo false)then{
    _battlefield set ["currentAction",    "Loading cover positions"];
    [_battlefield] call SFSM_fnc_getCoverPositionsLight;
};

private _loadingTime = time - (_battlefield get "Started");

[["Battlefield finished loading in ", _loadingTime, " seconds"]] call SFSM_fnc_debugMessage; 

_battlefield set ["currentAction",    "none"];
["battle_initialized", _battlefield] call CBA_fnc_localEvent;

//spawn a loop that updates the battlefield-hashmap every 10 seconds(can be changed in init-server)
[_battlefield] spawn SFSM_fnc_battleFieldUpdater;

true;