params ["_captive"];
sleep 1;
if  (animationState _captive isNotEqualTo "acts_executionvictim_loop")
then{
	_captive switchMove "Acts_executionvictim_Loop";
	[_captive] call SFSM_fnc_setCaptured;
};

if([_captive] call SFSM_fnc_isPlayer)exitWith{};

for "_i" from 1 to 30 do {
	sleep 10;
};

_captive setDamage 1;

true;