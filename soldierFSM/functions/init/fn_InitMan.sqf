// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man"];
private _data = _man getVariable "SFSM_UnitData";
if(!isNil "_data")exitWith{};
// if!([_man] call SFSM_fnc_isRealMan)exitWith{};

// if(isPlayer _man)exitwith{};
if([(group _man)] call Tcore_fnc_nilNull)exitWith{};

private _unitData = createHashMap;

// Setting all time variables to -300 to allow for 
// proper reactions from the start of the game  

_unitData set     ["Last_Hit",            -300];
_unitData set     ["Last_Close_Bullet",   -300]; 
_unitData set     ["last_bullet_fired",   -300];
_unitData set     ["flinchTimer",         -300];
_unitData set     ["dodgeTimer",          -300];
_unitData set     ["reactFireTimer",      -300];
_unitData set     ["lastBattle",          -300];
_unitData set     ["last_time_in_cover",  -300];
_unitData set     ["last_AmmoCheck",      -300];
_unitData set     ["lastSprintCheck",     -300];
_unitData set     ["lastPinDown",         -300];
_unitData set     ["huntStart",           -300];
_unitData set     ["huntEnded",           -300];
_unitData set     ["lastFipoAttempt",     -300];
_unitData set     ["peekCooldown",        -300];
_unitData set     ["lastPeek",            -300];
_unitData set     ["lastOverRun",         -300];
_unitData set     ["lastCqbRpgCheck",     0   ];
_unitData set     ["roundsPrSecond",      0   ];
_unitData set     ["action",              "none"];
_unitData set     ["flashAction",         ""    ];
_unitData set     ["currentBattle",       "none"];
_unitData set     ["currentBuilding",     "none"];
_unitData set     ["targetBuilding",      "none"];
_unitData set     ["currentDestination",  [0,0,0]];
_unitData set     ["hashValue",           hashvalue _man];
_unitData set     ["current suppression", (getSuppression _man)];
_unitData set     ['pathEnabeled',        (_man checkAIFeature "PATH")];
_unitData set     ["hunkObjectHash",      []];
_unitData set     ["flinchTimes",         []];
_unitData set     ["abortForcedMove",     false];
_unitData set     ["abortSprint",         false];
_unitData set     ["forcedMovement",      false];
_unitData set     ["inFipo",              false];
_unitData set     ["moraleEventsActive",  []];
_unitData set     ["moraleEvents",        []];
_unitData set     ["lastMoraleEvent",     -300];
_unitData set     ["baseMoraleChecked",   -300];
_unitData set     ["baseMorale",          1];
_unitData set     ["baseMoraleFactors",   createHashmap];
_unitData set     ["morale",              1];

_man setVariable["SFSM_UnitData",         _unitData, true];

_man setVariable["SFSM_prevTarget",     objNull,   true];
_man setVariable["SFSM_prevShooter",    objNull,   true];


if(_man getVariable ["SFSM_Excluded",false])exitWith{};

[_man] call SFSM_fnc_SuppressedEH;
[_man] call SFSM_fnc_firedEH;
[_man] call SFSM_fnc_hitEH;

//remove data on deletion to conserve memory
_man addEventHandler ["Deleted", {
        private _building = _unitData get "currentBuilding";
        if!(_building == "none")
        then{missionNamespace setVariable [_building, nil, true];};
        diag_log "Soldier FSM ==> unit deleted";
}];

_man addEventHandler ["InventoryOpened", {
	params ["_unit", "_container"];
	_this call SFSM_fnc_onInventoryOpened;
}];

[_man] call SFSM_fnc_autoStanceActions;
[_man] call SFSM_fnc_buddyRearmAction;
[_man] call SFSM_fnc_playerCallMedicAction;

true;