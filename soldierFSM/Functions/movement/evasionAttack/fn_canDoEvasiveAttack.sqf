params["_man", "_target"];
if!(SFSM_allowEvasionAttack)                          exitWith {false;};
if!([_man, true] call SFSM_fnc_canRun)                exitWith {false;};
if!([_man] call SFSM_fnc_hasAmmoForWeapon)            exitWith {false;};
if!([_target] call SFSM_fnc_functionalMan)            exitWith {false;};
if!([_man, _target] call SFSM_fnc_targetVisible)      exitWith {false;};
if(_man call SFSM_fnc_unitIndoor)                     exitWith {false;};
if(_target call SFSM_fnc_unitIndoor)                  exitWith {false;};
if(_man distance2D _target > 40)                      exitWith {false;};
if(_man distance2D _target < 6)                       exitWith {false;};
if([_man, "forcedMovement"] call SFSM_fnc_unitData)   exitWith {false;};
if(_man    getVariable ["SFSM_evasiveAttack", false]) exitWith {false;};
if(_target getVariable ["SFSM_evasiveAttack", false]) exitWith {false;};

true;