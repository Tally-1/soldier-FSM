params ["_groupLeader", "_turrets"];
for "_i" from 0 to (count _turrets)do{
	if(_turrets isEqualTo [])exitWith{};
	_turrets = [_groupLeader, _turrets] call SFSM_fnc_assignTurret;
};

true;