params ["_captive", "_captor"];
[_captor,  "none"] call SFSM_fnc_setAction;
    
if(animationState _captive in SFSM_panicAnimations)
then{[_captive, "!PANIC!"]  call SFSM_fnc_setAction;};

if(animationState _captive isEqualTo "acts_jetsmarshallingemergencystop_in")
then{[_captive, "Surrendered"]  call SFSM_fnc_setAction;};

if([_captive] call SFSM_fnc_isUnCon)then{
	[_captive, "none"]  call SFSM_fnc_setAction;
};

[_captor,  "capture failed"]        spawn SFSM_fnc_flashAction;
[_captive, "Enemy aborted capture"] spawn SFSM_fnc_flashAction;

true;