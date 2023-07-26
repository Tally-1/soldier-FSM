// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: ends self heal action

// Return value: none 

private _actionText = "none";
params [
    "_man",         // Object - (man)
    "_eh",            // number (index of eventHandler (local to the unit))
    "_actionText" // string (displayed when using debug-mode)
];
private _damage  = damage _man;
private _timeOut = time + 10;
waitUntil { damage _man != _damage or time > _timeOut };
// [_man, "action", _actionText] call SFSM_fnc_unitData;

if!("hunker" in _actionText)then{_man setUnitPos "AUTO"};

_man removeEventHandler ["HandleHeal", _eh];

private _vehicle = _man getVariable "SFSM_myVehicle";

if(!isNil "_vehicle")then{
_man action ["getInGunner", _vehicle];
_man setVariable ["SFSM_myVehicle", nil];
};