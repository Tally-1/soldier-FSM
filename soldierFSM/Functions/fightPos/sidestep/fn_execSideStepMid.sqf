params[
    ["_man", nil, [objNull]]
];
private _fipoDir = _man getVariable "SFSM_fipoDir";
if(isNil "_fipoDir")exitWith{};
    
_man setDir _fipoDir;
[_man, "peekCooldown", time+5] call SFSM_fnc_unitData;

true;