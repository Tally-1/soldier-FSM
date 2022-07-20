params ["_man", "_positions"];

private _counter  = 1; 
private _posCount = count _positions;

if(_posCount == 0)exitWith{};

{
	private _supPos = AGLToASL _x;
	private _supText = ["Suppressing position ", _counter, " of ", _posCount, "!"] joinString "";
	private _timer = time + 30;
	[_man, "action", _supText] call SFSM_fnc_unitData;
	_man doSuppressiveFire _supPos;

	waitUntil {sleep 0.1; ((!(currentCommand _man == "Suppress")) or time > _timer)};

	if(!alive _man)exitWith{};

	private _reloadNeeded = needReload _man > 0.9;

	if(_reloadNeeded)then{[_man, "action", "reloading!"] call SFSM_fnc_unitData; reload _man; sleep 7};

	_counter = _counter+1;
} forEach _positions;

[_man, "action", "none"] call SFSM_fnc_unitData;
true;