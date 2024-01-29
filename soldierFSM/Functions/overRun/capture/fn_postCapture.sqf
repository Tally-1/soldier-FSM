params ["_captive"];
sleep 1;
if  (animationState _captive isNotEqualTo "acts_executionvictim_loop")
then{
	_captive switchMove "Acts_executionvictim_Loop";
	[_captive] call SFSM_fnc_setCaptured;
};

if([_captive] call SFSM_fnc_isPlayer)  exitWith{};
if(SFSM_captiveAutoDeath isEqualTo -1) exitWith{};

// Sleeps the amount set i CBA settings then kills the captive.
for "_i" from 1 to SFSM_captiveAutoDeath do {
	sleep 60;
};

_captive setDamage 1;

true;