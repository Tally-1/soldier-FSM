params[
	["_man",         nil, [objNull]],
	["_suppressPos", nil,      [[]]]
];
private _barrelPos  = ([_man, 5]                    call SFSM_fnc_weaponAimPos)#0;
private _midPos     = [_barrelPos, _suppressPos, 5] call SFSM_fnc_posOnVector;
private _lineBroken = [_barrelPos, _midPos]         call SFSM_fnc_lineBroken;

private _validSuppressPos = _lineBroken isEqualTo false;

_validSuppressPos;