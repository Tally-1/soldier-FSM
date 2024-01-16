params[
    ["_man", nil, [objNull]]
];

private _unitData       = _man getVariable "SFSM_UnitData";
private _animListParams = _man getVariable "SFSM_animListParams";

//Exit if the animation is forced by SFSM engine
if(!isNil "_animListParams")              exitWith{false;};
if([_x, "inFipo"] call SFSM_fnc_unitData) exitWith{false;};

[_man] call SFSM_fnc_storeMoveData;

true;