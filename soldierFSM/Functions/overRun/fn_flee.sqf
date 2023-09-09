params["_man", "_enemies"];
[_man, "Fleeing  "] call SFSM_fnc_setAction;
private _dropWeapons = (random 1) > 0.7;
private _enemyPos    = getPosATLVisual ([_man, _enemies] call SFSM_fnc_getNearest);
private _manPos      = getPosATL _man;
private _fleedir     = _enemyPos getDir _manPos;
private _fleePos     = [_manPos, _fleedir, 400] call SFSM_fnc_sinCosPos2;
private _available   = [_fleePos, 200, 20] call Tcore_fnc_availablePositions;

if(_available isEqualTo [])exitWith{[_man] spawn SFSM_fnc_surrender;};

_fleePos = [_man, _available] call SFSM_fnc_getNearest;
["overrun_flee",  [_man, _enemies]] call CBA_fnc_localEvent;

if(_dropWeapons)then{
    // private _drop = 
    [_man] call SFSM_fnc_dropAllWeapons;
    // waitUntil{sleep 0.1; scriptDone _drop};
    _man switchMove "ApanPercMstpSnonWnonDnon";
};

_man enableAI "all";
_man disableAI "AUTOCOMBAT";
_man disableAI "AUTOTARGET";
_man disableAI "CHECKVISIBLE";
_man disableAI "COVER";
_man disableAI "FSM";
_man disableAI "SUPPRESSION";
_man disableAI "TARGET";
_man disableAI "WEAPONAIM";
_man setUnitPos "UP";

// _man allowFleeing 1;

// private _move = 
[_man, _fleePos] call SFSM_fnc_forceMove2;
// waitUntil{sleep 1; scriptDone _move;};

[_man, "none"] call SFSM_fnc_setAction;
_man enableAI "all";