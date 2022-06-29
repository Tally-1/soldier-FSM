params ["_posA", "_posB"]; 
private _dir      = _posA getDir _posB;
private _distance = (_posA distance2D _posB) / 2;

private _midpos = [_posA#0, _posA#1, _dir, _distance] call Tcore_fnc_sinCosPos;

_midpos