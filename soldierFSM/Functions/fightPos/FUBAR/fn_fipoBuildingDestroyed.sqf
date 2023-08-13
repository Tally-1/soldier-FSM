params ["_from", "_to", "_isRuin"];

private _shape = [_to] call Tcore_fnc_object3DShape;

private _size  = selectMax [(_shape get "width"),(_shape get "length")];
if(_size < 3)exitWith{};

private _fipos = SFSM_fipositions select {(_x distance2D _to) < _size};
if(_fipos isEqualTo [])exitwith{};

// Suspend to allow the destroyed building to fall.
private _timer = time + 3;
waitUntil  { sleep 1; 
           ((getPosATLVisual _from)#2) < 5
		|| {time > _timer}};

// Check all FIPOs within the building-radius, and deactivate the ones who have no footing.
{
	private _destroyed = [_x] call SFSM_fnc_fipoIsDestroyed;
	if(_destroyed)then{_x setVariable ["destroyed", true];};
	
} forEach _fipos;

true;