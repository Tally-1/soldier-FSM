params["_man", "_enemy"];
if ([_man, _enemy] call SFSM_fnc_validEnemyVehicle)        exitWith{true;};
if!([_enemy, true, true, true, true] call SFSM_fnc_canRun) exitWith{false;};
if!([_man, _enemy] call SFSM_fnc_hostile)                  exitWith{false;};
if!(side _man in [east, west, independent])                exitWith{false;};
if!(side _enemy in [east, west, independent, sideEnemy])   exitWith{false;};

true;