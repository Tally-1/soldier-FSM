params ["_man", "_enemyPos"];
private _coverPos = [_man] call Tcore_fnc_coverPosSimple;
if(isNil "_coverPos")
exitWith{[_man, _enemyPos, false] call SFSM_fnc_Dodge};
[_man, _coverPos] spawn SFSM_fnc_takeCover;