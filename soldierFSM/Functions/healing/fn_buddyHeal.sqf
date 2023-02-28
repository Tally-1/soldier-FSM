params["_healer", "_wounded"];
private _healerName  = name _healer;
private _woundedName = name _wounded;
private _timeLimit   = 20;
private _timer       = time + _timeLimit;
private _centerPos   = [(getPos _healer), (getPos _wounded)] call Tcore_fnc_getMidpoint;
private _radius      = _healer distance2D _wounded;
private _coverPos    = [_healer, _centerPos, _radius] call SFSM_fnc_getCoverPos;
private _hAction     = ["healing ", _woundedName]joinString "";
private _wAction     = ["being healed by ", _healerName]joinString "";

[_healer, "action", _hAction] call SFSM_fnc_unitData;
[_wounded, "action", _wAction] call SFSM_fnc_unitData;

if(isNil "_coverPos")then{_coverPos = [_wounded, _radius] call Tcore_fnc_coverPosSimple;};
if(isNil "_coverPos")then{_coverPos = _centerPos;};

private _runH = [_healer,  _coverPos, _timeLimit, 2] spawn SFSM_fnc_forceMove2;//SFSM_fnc_forceMoveToPos;
private _runW = [_wounded, _coverPos, _timeLimit, 2] spawn SFSM_fnc_forceMove2;//SFSM_fnc_forceMoveToPos;


waitUntil{
			sleep 1;
			
			if(scriptDone _runH)then{_healer disableAI "path";};
			if(scriptDone _runW)then{_wounded disableAI "path";};

			(scriptDone _runH
			&&{scriptDone _runW}
			|| time > _timer);		
};

private _canHeal = [_healer, _wounded, true, 7] call SFSM_fnc_canBuddyHeal;

if!(_canHeal)exitWith{
	[_healer, _wounded, false] spawn SFSM_fnc_endBuddyHeal;
};

_healer action ["HealSoldier", _wounded];

sleep 1;

[_healer, _wounded, true] spawn SFSM_fnc_endBuddyHeal;