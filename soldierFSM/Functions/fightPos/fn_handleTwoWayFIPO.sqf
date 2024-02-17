params[
	["_man",  nil, [objNull]],
	["_fipo", nil, [objNull]]
];
if!(_this call SFSM_fnc_canChangeFipoDir)exitWith{};

private _fipoDir    = getDirVisual _fipo;
private _newFipoDir = [_fipoDir-180] call Tcore_fnc_formatDir;

_fipo setVariable ["SFSM_fipoSide", side _man];
_fipo setDir _newFipoDir;

[_man, "Fipodir changed", 3] spawn SFSM_fnc_flashAction;

true;