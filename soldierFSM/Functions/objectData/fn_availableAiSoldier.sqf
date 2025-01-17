private _ignoreAction = false;
params[
	["_man",          nil, [objNull]],
	["_ignoreAction", false,  [true]]
];
if!([_man, true] call SFSM_fnc_canRun)                  exitWith{false};
if ([_man, "forcedMovement"] call SFSM_fnc_unitData)    exitWith{false};
if ([_man] call SFSM_fnc_isPlayer)                      exitWith{false};
if ([_man] call SFSM_fnc_inFipo)                        exitWith{false};
if (primaryWeapon _man isEqualTo "")                    exitWith{false};
if (_man getVariable ["SFSM_Excluded",  false])         exitWith{false};
if (_man getVariable ["SFSM_Sprinting", false])         exitwith{false};
if (_man getVariable ["SFSM_reviving", false])          exitwith{false};
if (fleeing _man)                                       exitWith{false};

private _revivetarget = _man getVariable "SFSM_myReviveTarget";
if(!isNil "_revivetarget")exitWith{false};

//If unit is hunting (Marksman FSM)
private _huntPos = _man getVariable ["SFSM_huntStartPos", [0,0,0]];
if(_huntPos isNotEqualTo [0,0,0])exitWith{false};

//If action is not ignored, and the unit is doing something
if(_ignoreAction isEqualTo false
&&{[_man] call SFSM_fnc_getAction isNotEqualTo "none"})exitWith{false};

true;