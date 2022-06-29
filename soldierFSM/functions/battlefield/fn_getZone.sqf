params ["_positions", "_minRadius"];
private _center = [_positions] call Tcore_fnc_avgPos;
private _radius = 0;

if!(_center isEqualTo [])
then{
		_radius = [_center, _positions] call Tcore_fnc_clusterSize;
		_radius = _radius*1.2;
		if(_radius < _minRadius)then{_radius = _minRadius};
	
	};

[_center, _radius];