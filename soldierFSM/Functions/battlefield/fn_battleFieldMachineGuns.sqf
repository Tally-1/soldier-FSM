//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Returns all machineguns in a given distance to a given unit, the data is retrieved from a battlefield dataobject

// Params: [_soldier, _battlefield] - soldier: Object, battlefield: hashmap

// Return value: Array of objects

// Example: [_soldier, _battlefield] call SFSM_fnc_battleFieldMachineGuns

params["_man", "_battlefield"];
private _weapons = missionNamespace getVariable (_battlefield get "weapons");
private _machineguns =
_weapons select {

    private _inDistance  = _man distance2D _x <= SFSM_DodgeDistance;
    private _weaponType  = getWeaponCargo _x#0#0;
    private _classId     = ([_weaponType] call objScan_fnc_weaponData) get "class ID";
    private _machinegun  = ((_classId > 2.5 && {_classId < 4})
                        or(_classId >= 1.7 && {_classId <= 1.8}));

    _inDistance
    &&{_machinegun};
};

_machineguns;