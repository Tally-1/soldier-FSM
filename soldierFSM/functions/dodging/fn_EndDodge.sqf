params ["_man", "_endPos", "_timer", "_target", "_behaviour"];

waitUntil{sleep 1; [_man, _endPos, _timer] call Tally_Fnc_dodgeEnded};

if(SFSM_forceDodge)
then{
	
	//_man enableAI "FSM";
	_man enableAI "TARGET";
	_man enableAI "AUTOCOMBAT";
	_man enableAI "AUTOTARGET";
	
	_man doTarget _target;
	
	_man setUnitPos "AUTO";
	//_man setBehaviourStrong _behaviour;

};

[_man, "dodging", 	false] 	call Tally_Fnc_SFSM_unitData;
[_man, "action", 	"none"]	call Tally_Fnc_SFSM_unitData;