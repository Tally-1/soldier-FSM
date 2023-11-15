private _groups   = allGroups select {units _x isNotEqualTo []};
private _turrets = vehicles select {[_x] call SFSM_fnc_turretAvailable;};

if(_turrets isEqualTo []) exitWith{};
if(_groups isEqualTo [])  exitWith{};

[_turrets, _groups] call SFSM_fnc_getTurretsAndLeaders 
params ["_turrets", "_leaders"];

if(_turrets isEqualTo [])  exitWith{};
if(_leaders isEqualTo [])  exitWith{};

{
    [_x, _turrets] call SFSM_fnc_assignMenToTurrets;
    sleep 0.3;
} forEach _leaders;

true;