params ["_man", "_endPos"];
private _distanceToPos = (_man distance2D _endPos);

if(_distanceToPos < 2.5)
then{
		_man disableAI "PATH";
		[_man, "pathEnabeled", false]	call SFSM_fnc_unitData;
		[_man, "action", "Holding cover position"]	call SFSM_fnc_unitData;
		
		sleep SFSM_stayCoverPosTime;


		_man enableAI "PATH";
		[_man, "pathEnabeled", true]call SFSM_fnc_unitData;
		[_man, "action", "none"]	call SFSM_fnc_unitData;
    };


[_man] call SFSM_fnc_postCoverActions;

true;