params["_man"];
if (time < 120)                                exitWith{false;};
if (speed _man > 1)                            exitWith{false;};
if!([_man, true]  call SFSM_fnc_canRun)        exitWith{false;};
if!([_man, false] call SFSM_fnc_canResetBrain) exitWith{false;};
if ([_man]        call SFSM_fnc_hasMoved)      exitWith{false;};

private _data     = _man getVariable "SFSM_unitData";
private _action   = _data get"action";
private _isZombie = _data get "isBrainDead";

if(_action isNotEqualTo "none") exitWith {false;};

private _timeSinceLastMove = [_man] call SFSM_fnc_timeSinceLastMove;
if(_timeSinceLastMove < 120) exitWith {false;};

private _timeSinceBraincheck = time - (_data get "lastbrainCheck");

if(_timeSinceBraincheck < 120
&&{_isZombie isEqualTo false}) exitWith {false;};

private _canChangeStance = [_man] call SFSM_fnc_canChangeStance;

if(_canChangeStance)
then{_data set ["isBrainDead", false];}
else{_data set ["isBrainDead", true];};


_data set ["lastbrainCheck", time];
_canChangeStance;