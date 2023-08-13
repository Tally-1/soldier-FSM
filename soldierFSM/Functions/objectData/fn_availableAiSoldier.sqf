private _ignoreAction = false;
params["_man", "_ignoreAction"];
if!([_man, true] call SFSM_fnc_canRun)                  exitWith{false;};
if ([_man, "forcedMovement"] call SFSM_fnc_unitData)    exitWith{false;};
if ([_man] call SFSM_fnc_isPlayer)                      exitWith{false;};
if ([_man] call SFSM_fnc_inFipo)                        exitWith{false;};
if (primaryWeapon _man isEqualTo "")                    exitWith{false;};
if (_man getVariable ["SFSM_Excluded",  false])         exitWith{false;};
if (_man getVariable ["SFSM_Sprinting", false])         exitwith{false;};
if (fleeing _man)                                       exitWith{false;};

//If unit is hunting (Marksman FSM)
private _huntPos = _man getVariable ["SFSM_huntStartPos", [0,0,0]];
if(_huntPos isNotEqualTo [0,0,0])exitWith{false;};

//If action is not ignored, and the unit is doing something
if(_ignoreAction isEqualTo false
&&{[_man] call SFSM_fnc_getAction isNotEqualTo "none"})exitWith{false;};

true;