params[
    ["_man",      nil, [objNull]],
    ["_building", nil, [objNull]]
];
private _impactPos  = [_man, _building] call SFSM_fnc_getHouseTargetPos;
if(isNil "_impactPos")exitWith{true;};

_impactPos = ASLToATL _impactPos;

private _friendlies = (_impactPos nearEntities ["caManBase", 7])select{side _x isEqualTo side _man;};
if(_friendlies isEqualTo [])exitWith{true;};

false;