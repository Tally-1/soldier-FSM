params ["_man", "_endPos"];
private _distanceToPos = (_man distance2D _endPos);
private _positionIsAvailable = true;



if(_distanceToPos < 2.5)
then{
		private _soldiersInPosition = count([_man, 3] call Tcore_fnc_nearSoldiers);

		if(_soldiersInPosition > 1)exitWith{_positionIsAvailable = false};
		
		_man disableAI "PATH";
		[_man, "pathEnabeled", false]	call SFSM_fnc_unitData;
		[_man, "action", "Holding cover position"]	call SFSM_fnc_unitData;
		
		sleep SFSM_stayCoverPosTime;


		_man enableAI "PATH";
		[_man, "pathEnabeled", true]call SFSM_fnc_unitData;
		[_man, "action", "none"]	call SFSM_fnc_unitData;
    };

if!(_positionIsAvailable)exitWith{[_man, _endPos] call SFSM_fnc_forceCoverDodge};


[_man] call SFSM_fnc_postCoverActions;

true;

/*



*/