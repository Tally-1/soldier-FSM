params["_man"];
if(time - ([_man, "lastCqbRpgCheck"] call SFSM_fnc_unitData) < 60) exitWith{};
[_man, "lastCqbRpgCheck", time] call SFSM_fnc_unitData;

private _target = (getAttackTarget _man);

if (!alive _target)                                                exitWith{};
if (_man distance2D _target < 20)                                  exitWith{};
if!([_man, _target] call SFSM_fnc_validEnemy)                      exitWith{};
if!([_man] call SFSM_canRpgHouse)                                  exitWith{};
if!([_man, true] call SFSM_fnc_canRun)                             exitWith{};

private _building = [_target] call SFSM_fnc_currentBuilding;
if(isNil "_building")exitWith{};


"Forcing RPG at building" call dbgmsg;
[_man, _building] spawn SFSM_fnc_rpgHouse;