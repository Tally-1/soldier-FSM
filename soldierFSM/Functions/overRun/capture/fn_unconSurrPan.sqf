params["_man"];
if(!alive _man)                  exitWith{false;};
if([_man] call SFSM_fnc_isUncon) exitWith{true;};

if(_man getVariable ["SFSM_surrendered", false]  
&&{[_man] call SFSM_fnc_getAction isEqualTo "Surrendered"}) exitWith{true;};

if(_man getVariable ["SFSM_panic", false]  
&&{[_man] call SFSM_fnc_getAction isEqualTo "!PANIC!"})     exitWith{true;};

false;