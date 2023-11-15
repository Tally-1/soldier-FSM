// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_turret", "_man"];

private _assignedGunner = (_turret getVariable ["SFSM_gunner", objNull])==_man;
if(_assignedGunner)then{
    [_man, "action", "none"]   call SFSM_fnc_unitData;
};

private _action = [_man] call SFSM_fnc_getAction;
if(_action isEqualTo "Manning turret!")then{
    [_man, "action", "none"]   call SFSM_fnc_unitData;
};


private _eh = _turret getVariable "SFSM_getOutEH";
if(!isNil "_eh")then{
_turret removeEventHandler ["GetOut", _eh];
};

_turret setVariable        ["SFSM_gunner", nil];
_turret setVariable        ["SFSM_getOutEH", nil];

unassignVehicle _man;

[_man] call SFSM_fnc_initOverrun;