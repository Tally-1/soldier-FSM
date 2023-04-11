params ["_man"];

if(_man getVariable ["SFSM_Excluded",false])         exitWith{false};
if([_man] call PrMed_fnc_isUnconscious)              exitWith{false};
if(_man getVariable ["dam_ignore_injured0",false])   exitWith{false;};
if(!([_man] call SFSM_fnc_hasMedKit))                exitWith{false};
if(SFSM_EmergencyHealing isEqualTo "disabeled")      exitWith{false};
if(!alive _man)                                      exitWith{false};
// if(_man getVariable ["ace_isunconscious", false])exitWith{false};
// if(_man getVariable ["SFSM_Sprinting", false])   exitwith{false;};

true;