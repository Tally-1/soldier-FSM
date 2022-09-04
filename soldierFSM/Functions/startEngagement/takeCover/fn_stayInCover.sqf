params["_man", "_endPos"];
private _timer = time + SFSM_stayCoverPosTime;
private _stayInCover = true;
private _hitByBullet = false;


//disable some ai, and update state
_man disableAI "PATH";
[_man, "pathEnabeled", false]	call SFSM_fnc_unitData;
[_man, "action", "Holding cover position"]	call SFSM_fnc_unitData;
_man setCombatBehaviour "STEALTH";

while {sleep 0.5; _stayInCover} do {
	private _timeSinceLastHit = time - ([_man, "Last_Hit"]	call SFSM_fnc_unitData);
	private _hitByBullet      = (_timeSinceLastHit < 1.1 && SFSM_breakCoverOnHit);
	private _timedOut         = time > _timer;

	if(_timedOut || _hitByBullet)
	then{_stayInCover = false};
};

[_man, _endPos, _hitByBullet]call SFSM_fnc_endStayInCover;


true;