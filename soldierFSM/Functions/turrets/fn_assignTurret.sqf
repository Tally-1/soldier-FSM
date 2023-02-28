params ["_groupLeader", "_turrets"];
private _group             = group _groupLeader;
private _availableSoldiers = [_group] call SFSM_fnc_availableRegulars;
if(_availableSoldiers isEqualTo [])exitWith{};

private _availableTurrets  = _turrets select {[_x] call SFSM_fnc_turretAvailable
                                           &&{_x distance2D _groupLeader < SFSM_turretLeaderDist}};
if(_availableTurrets isEqualTo []) exitWith{};
private _turret    = (([_availableTurrets, [], {_groupLeader distance _x }, "ASCEND"] call BIS_fnc_sortBy))#0;
private _newGunner = (([_availableSoldiers, [], {_turret distance _x }, "ASCEND"] call BIS_fnc_sortBy))#0;

[["Assigning turret to ", (name _newGunner)],1] call dbgmsg;
[_newGunner, _turret] spawn SFSM_fnc_mountTurret;