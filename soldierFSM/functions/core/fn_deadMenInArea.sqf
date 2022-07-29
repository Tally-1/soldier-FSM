params ["_pos", "_radius"];
private _deadMenInArea = [];
{
	private _distance = _pos distance2D _X;
	
	if(_distance < _radius)then{_deadMenInArea pushback _X};
	
} forEach alldeadMen;

_deadMenInArea;