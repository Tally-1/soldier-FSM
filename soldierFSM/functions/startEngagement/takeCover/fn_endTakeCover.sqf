params ["_man", "_endPos"];
private _distanceToPos = (_man distance2D _endPos);
private _positionIsAvailable = true;



if(_distanceToPos < 2.5)
then{
		private _soldiersInPosition = count([_man, 3] call Tcore_fnc_nearSoldiers);

		if(_soldiersInPosition > 1)exitWith{_positionIsAvailable = false};
		
		private _script = [_man, _endPos] spawn SFSM_fnc_stayInCover;
		waitUntil {sleep 1; scriptDone _script};

    };

if!(_positionIsAvailable)exitWith{[_man, _endPos] call SFSM_fnc_forceCoverDodge};


[_man] call SFSM_fnc_postCoverActions;

true;

/*



*/