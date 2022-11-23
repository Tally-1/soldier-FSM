private _allowPanic = false;
params ["_grenade", "_man", "_distance", "_allowPanic"];

private _action = [_man, "action"] call SFSM_fnc_unitData;

if("hunker" in _action)
then{[_man, nil, "Grenade landed near"] call SFSM_fnc_endHunker;};

if(_man getVariable ["SFSM_excluded", false])exitWith{};
if!([_man, "pathEnabeled"] call SFSM_fnc_unitData)exitWith{};


[_man, "action", "Evading grenade"]	call SFSM_fnc_unitData;

private _tim3r = time +5;
private _evasionDir = (_man getDir _grenade)-180;

_man setDir _evasionDir;
_man playMoveNow "AmovPercMevaSrasWrflDf";

sleep 0.621;

while{_tim3r > time}
do{
	_man playMove "AmovPercMevaSrasWrflDf";
	if (speed _man == 0
	&& {_tim3r - time < 4})
	exitWith{};
	sleep 0.621;
};

if(_man Distance2d _grenade < _distance)
then{
		private _panic = [_man, true] spawn SFSM_fnc_eyelidTrench;
		waitUntil { scriptDone _panic; };
};

[_man, "action", "none"]	call SFSM_fnc_unitData;

true;