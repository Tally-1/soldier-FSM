params["_battleField"];
private _pos    = (_battleField get "center");
private _radius = (_battleField get "radius");
private _units  = missionNamespace getVariable (_battleField get "units");
private _unitsFighting = [];

{
	private _target = getAttackTarget _x;
	if(!isNull _target
	&&{(_target distance2D _pos) < _radius})
	then{
			_unitsFighting pushBack _x;
		};
} forEach _units;

_unitsFighting