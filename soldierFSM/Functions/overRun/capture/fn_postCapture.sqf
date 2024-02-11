params ["_captive"];
sleep 1;
if  (animationState _captive isNotEqualTo "acts_executionvictim_loop")
then{
	_captive switchMove "Acts_executionvictim_Loop";
	[_captive] call SFSM_fnc_setCaptured;
};

true;