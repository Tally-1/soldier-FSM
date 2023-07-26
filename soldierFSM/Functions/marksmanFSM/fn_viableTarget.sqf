params["_marksman", "_target"];
if!([_target]   call SFSM_fnc_isRealMan)exitWith{false};

private _targetSide   = (side _target);
private _marksmanSide = (side _marksman);
private _distance = _marksman distance _target;

if (_distance > 1000)                                         exitWith{false};
if ([_target]   call SFSM_fnc_isUncon)                        exitWith{false};
if ([_marksman] call SFSM_fnc_isUncon)                        exitWith{false};
if (_targetSide == _marksmanSide)                             exitWith{false};
if ([_targetSide, _marksmanSide] call BIS_fnc_sideIsFriendly) exitWith{false};
if (_targetSide   == civilian)                                exitWith{false};
if (_marksmanSide == civilian)                                exitWith{false};
if (captive _target)                                          exitWith{false};
if (_target == _marksman)                                     exitWith{false};

true;