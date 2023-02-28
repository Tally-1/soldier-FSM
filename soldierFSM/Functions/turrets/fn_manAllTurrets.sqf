params["_vehicles", "_groups"];
if(_vehicles isEqualTo []) exitWith{};
if(_groups isEqualTo [])   exitWith{};

private _TnL = [_vehicles, _groups] call SFSM_fnc_getTurretsAndLeaders;
private _turrets = _TnL#0;
private _leaders = _TnL#1;

if(_turrets isEqualTo [])  exitWith{};
if(_leaders isEqualTo [])  exitWith{};

{
	[_x, _turrets] call SFSM_fnc_assignTurret;
	sleep 0.3;
} forEach _leaders;