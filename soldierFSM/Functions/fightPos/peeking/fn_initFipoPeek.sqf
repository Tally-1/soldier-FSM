params["_man"];
if!([_man] call SFSM_fnc_canFipoPeek)exitWith{false;};

if!(_man checkAIFeature "anim")then{_man enableAI "anim";};
[_man] spawn SFSM_fnc_fipoPeek;

true;