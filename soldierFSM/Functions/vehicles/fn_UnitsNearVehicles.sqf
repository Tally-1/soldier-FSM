params["_units","_vehicles", "_maxDistance"];
private _unitsInReach = [];
{
	private _nearestVehicle = [_x, _vehicles] call Tcore_fnc_nearestPos;
	if(typeName _nearestVehicle == "object"
	&&{(_nearestVehicle distance2D _x) < _maxDistance
	&&{alive _x
	&&{(!(_x getVariable ["ace_isunconscious", false]))
	&&{!(_x getVariable ["dam_ignore_injured0",false])
	}}}})
	then{_unitsInReach pushBack _x;};
	
} forEach _units;


_unitsInReach;