params ["_man"];
if!([_man] call SFSM_fnc_isRealMan)exitwith{"not a real man" call dbgmsg; false;};

private _enType        = SFSM_disableSpecialists;
private _leader        = (leader group _man);
private _playerLead    = _leader in allPlayers;
private _playerSpecial = false;

//if specialist actions are disabled for everyone
if(_enType isEqualTo "all") exitWith {[_man, false] call SFSM_fnc_allowSpecial;};

//if specialist actions are disabled for nobody
if(_enType isEqualTo "none")exitWith {[_man, true] call SFSM_fnc_allowSpecial};

//if specialist actions are disabeled for player squad
if(_playerLead)exitWith{[_man, false] call SFSM_fnc_allowSpecial;};

true;