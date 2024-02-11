if(SFSM_captiveAutoDeath isEqualTo -1) exitWith{};
if(SFSM_captivesToDie isEqualTo [])    exitWith{};

SFSM_captivesToDie = 
SFSM_captivesToDie select {[_x#0] call SFSM_fnc_isValidCaptive;};

private _menKilled    = 0;
private _dataToDelete = [];

{
	private _killed = _x call SFSM_fnc_autoKillCaptive;
	if(_killed)then{
		_dataToDelete pushBackUnique _x;
		_menKilled = _menKilled+1;
	};

} forEach SFSM_captivesToDie;

if(_menKilled < 1)exitWith{};

[[_menKilled, " captives got the vaccine."]]call dbgMsg;


SFSM_captivesToDie =
[
	_dataToDelete,
	SFSM_captivesToDie

] call SFSM_fnc_deleteValuesFromArr;

true;