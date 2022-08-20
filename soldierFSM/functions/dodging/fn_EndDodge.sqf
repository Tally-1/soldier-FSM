params ["_man", "_endPos", "_timer", "_target", "_behaviour"];

waitUntil{sleep 0.5; [_man, _endPos, _timer] call SFSM_fnc_dodgeEnded}; 


if(SFSM_forceDodge)
then{
	
	_man enableAI "TARGET";
	_man enableAI "AUTOCOMBAT";
	_man enableAI "AUTOTARGET";
	
	_man doTarget _target;
	
	_man setUnitPos "AUTO";
};

_man setAnimSpeedCoef 1;
[_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;

//if the dodge was ended by a flinch then exit the script before setting action = "none"
//and init hunker
private _action = [_man, "action"] call SFSM_fnc_unitData;
if(_action in ["reacting", "flinch"])exitWith{};


_man doMove (getPos _man);

[_man, "action", 	"none"]	call SFSM_fnc_unitData;


[_man] spawn SFSM_fnc_randomHunkerInit;

true;