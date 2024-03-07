params[
	["_man", nil, [objNull]]
];
private ["_evasionPos"];
private _dirMan    = getDirVisual _man;
private _startDir  = selectRandom [_dirMan+90,_dirMan-90, _dirMan, _dirMan+180];
private _positions = [
	_man,
	10,
	_startDir,
	12

] call SFSM_fnc_get360PosASL;

{
	if!(isNil "_evasionPos")
	exitWith{};
	
	if!([aimPos _man, _x, _man] call SFSM_fnc_lineBroken)
	exitWith{_evasionPos = _x;};
	
} forEach _positions;

if(isNil "_evasionPos")exitWith{};

private _dir = _man getDir _evasionPos;

_dir;