params[
	["_thrower",   nil, [objNull]], // The man throwing the smoke 
	["_posToHide", nil,      [[]]] //  The position to obscure
];
private _contraWindDir = [(windDir -180)] call Tcore_fnc_formatDir;
private _smokePos      = [_posToHide, _contraWindDir, 10] call SFSM_fnc_sinCosPos2;
private _smokeDir      = [(_thrower getDir _smokePos)]call Tcore_fnc_formatDir;

_smokeDir;