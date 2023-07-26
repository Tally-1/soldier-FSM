//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Gets all supplies(weapons / crates ++) on a battlefield

// Params: [_man:object, _battlefield:hashmap, _ignoreDistance:bool]

// Return value: array of objects

// Example:  [_unit1, _battlefield, true] call Tcore_fnc_battleFieldSupplies;

private _ignoreDistance = false;
params["_man", "_battlefield", "_ignoreDistance"];
private _supplies = missionNamespace getVariable (_battlefield get "supplies");
private _deadMen  = missionNamespace getVariable (_battlefield get "deadMen");

_supplies append _deadMen;

_supplies = _supplies select {

    private _isMan       = _x isKindOf "man";
    private _liveMan     = _isMan && {alive _x};
    private _vehicle     = _x isKindOf "land" && {(! _isMan)};
    private _liveVehicle = _vehicle && {!([_x] call Tcore_fnc_deadCrew)};
    private _inDistance  = (_man distance2D _x <= SFSM_DodgeDistance) || _ignoreDistance;

    _inDistance
    &&{(! _liveMan)
    &&{(! _liveVehicle)}}
};


_supplies;