params["_man"];
if!(alive _man)exitWIth{};
(([_man, 100] call SFSM_fnc_weaponAimPos) apply {ASLToAGL _x})
params["_weaponPos", "_endWeapon"];
private _wpsL = [_weaponPos, [-0.1,0,0]] call SFSM_fnc_addToPosValues;
private _wpsR = [_weaponPos, [0.1,0,0]]  call SFSM_fnc_addToPosValues;

private _line      = [_weaponPos, _endWeapon, [0.4, 1, 0.9, 1]];
private _lineLeft  = [_wpsL, _endWeapon, [1,0,0,1]];
private _lineRight = [_wpsR, _endWeapon, [0,1,0,1]];

if(!isNil "_line")      then{drawLine3D _line;};
if(!isNil "_lineLeft")  then{drawLine3D _lineLeft;};
if(!isNil "_lineRight") then{drawLine3D _lineRight;};
