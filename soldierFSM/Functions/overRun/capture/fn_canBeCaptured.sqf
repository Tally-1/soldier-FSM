params["_man"];
private _group = group _man;
if (isNull _group)                     exitWith{false;};
if!(_man isKindOf "CAManBase")         exitWith{false;};
if (side _group isEqualTo sideLogic)   exitWith{false;};
if (isObjectHidden _man)               exitWith{false;};
if!([_man] call SFSM_fnc_unconSurrPan) exitWith{false;};
// if ([_man] call SFSM_fnc_isPlayer)     exitWith{false;};

true;