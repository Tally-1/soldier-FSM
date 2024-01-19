params[
    ["_man",    nil, [objNull]],
    ["_objArr", nil,      [[]]]
];
private _hasValidEnemy = false;

{
    if([_man, _x] call SFSM_fnc_validEnemy)
    exitWith{_hasValidEnemy = true};
    
} forEach _objArr;

_hasValidEnemy;