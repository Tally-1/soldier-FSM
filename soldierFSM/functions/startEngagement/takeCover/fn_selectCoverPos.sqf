params ["_man", "_coverPositions", "_battleField"];
private _units = missionNamespace getVariable (_battleField get "units");
private _occupiedPositions  = [];
private _availablePositions = [];
private _coverPos = nil;

{
	if!(_x == _man)
	then{
			_occupiedPositions pushBack ([_x, "currentDestination"] call SFSM_fnc_unitData);
			_occupiedPositions pushBack (getPos _x);
		};
} forEach _units;

{
	private _nearestPos  = [_x, _occupiedPositions] call Tcore_fnc_nearestPos; 
	private _found       = !(typeName _nearestPos == "SCALAR");
	private _distance    = 3;
	if(_found)then{_distance = (_X distance2D _nearestPos)};

	if(_distance > 1)
	then{_availablePositions pushBackUnique _x};

} forEach _coverPositions;

if!(count _availablePositions > 0)
then{							  
		_coverPos = [_man, _availablePositions] call Tcore_fnc_nearestPos;
	};

if(isNil "_coverPos")exitWith{nil};
_coverPos