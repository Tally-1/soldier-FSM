params["_man", "_state", "_eventType"];
if(_eventType isNotEqualTo "SetSurrendered") exitWith{};
if(_state isEqualTo false)                   exitWith{};
if(!local _man)                              exitWith{};


[_man]  remoteExecCall ["SFSM_fnc_captureAction", 0];

true;