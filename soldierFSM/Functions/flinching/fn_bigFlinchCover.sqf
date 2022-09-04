params ["_man", "_launchPos", "_shooter"];
if([_man] call Tcore_fnc_isPlayer)exitWith{};

private _timer     = time + 5;
private _canFlinch = [_man] call SFSM_fnc_canFlinch;

if(_canFlinch)	
then{
		[_man, true, _shooter] call SFSM_fnc_flinch;
		waitUntil{sleep 0.25; [_man, _timer] call SFSM_fnc_manAvailable};
		[_man] call SFSM_fnc_normalizeStance;
	};

[_man, _launchPos] call SFSM_fnc_eventTriggeredCover;