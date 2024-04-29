params["_man", "_target"];
if!(SFSM_allowEvasionAttack)                                exitWith {false;};

if (_man distance2D _target > 40)                           exitWith {false;};
if (_man distance2D _target < 6)                            exitWith {false;};

if ([_man, "forcedMovement"] call SFSM_fnc_unitData)        exitWith {false;};
if (_man    getVariable ["SFSM_evasiveAttack", false])      exitWith {false;};
if (_target getVariable ["SFSM_evasiveAttack", false])      exitWith {false;};

private _timeSince = (_man getVariable "SFSM_UnitData") call ["timeSinceEvasiveAttack"];
if (_timeSince < SFSM_evasionAttackCoolDown)                exitWith {false;};
if!([_man] call SFSM_fnc_hasAmmoForWeapon)                  exitWith {false;};
if!([_man, true] call SFSM_fnc_canRun)                      exitWith {false;};
if!([_target] call SFSM_fnc_functionalMan)                  exitWith {false;};

private _noLOS = [eyePos _man, eyePos _target, _man, _target] call SFSM_fnc_lineBroken;
if (_noLOS)                                                 exitWith {false;};
if (_man call SFSM_fnc_unitIndoor)                          exitWith {false;};
if (_target call SFSM_fnc_unitIndoor)                       exitWith {false;};

true;