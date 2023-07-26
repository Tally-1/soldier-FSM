params["_man"];

private _leader = leader group _man;
private _distance = _man distance2D  _leader;
if(_distance > SFSM_specRegroupDist)  exitWith{true;};

private _mode       = unitCombatMode _man;
private _playerLead = _leader in allPlayers;
private _action     = [_man] call SFSM_fnc_getAction;

if(_action isEqualTo "Forced regroup") exitWith {false;};
if!(_playerLead)                       exitWith {false;};
if(_mode == "RED")                     exitWith {false;};
if(_mode == "WHITE")                   exitWith {false;};


true;