["ace_medical_CriticalInjury", {
params["_man"];
isNil{[_man] call SFSM_fnc_onKnockOut;};

}] call CBA_fnc_addEventHandler;

["ace_medical_knockout", {
params["_man"];
isNil{[_man] call SFSM_fnc_onKnockOut;};

}] call CBA_fnc_addEventHandler;


["ace_medical_WakeUp", {
params["_man"];
isNil{[_man] call SFSM_fnc_onWakeUp;};

}] call CBA_fnc_addEventHandler;