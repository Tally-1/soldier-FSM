params ["_man", "_endPos", "_timer", "_target", "_behaviour"];

waitUntil
			{
				sleep 1;
				_man moveTo _endPos;
				_man doMove _endPos;
				[_man, _endPos, _timer] call SFSM_fnc_dodgeEnded;
			};

if(SFSM_forceDodge)
then{
	
	_man enableAI "TARGET";
	_man enableAI "AUTOCOMBAT";
	_man enableAI "AUTOTARGET";
	
	_man doTarget _target;
	
	_man setUnitPos "AUTO";

};

[_man, "action", "none"] call SFSM_fnc_unitData;


[_man] spawn SFSM_fnc_randomHunkerInit;

true;