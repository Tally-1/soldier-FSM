params[
	["_man",   nil, [objNull]],
	["_enemy", nil, [objNull]]
];

if ([_man, _enemy] call SFSM_fnc_validEnemyVehicle)        exitWith{true;};
if!([_enemy] call SFSM_fnc_functionalMan)                  exitWith{false;};
if!([_man, _enemy] call SFSM_fnc_hostile)                  exitWith{false;};
if!(side _man in [east, west, independent])                exitWith{false;};
if!(side _enemy in [east, west, independent, sideEnemy])   exitWith{false;};

true;