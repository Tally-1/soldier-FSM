params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
if!(_key in [30,31,32,17])                           exitWith{false;};
if(player getVariable ["SFSM_breakingCuffs", false]) exitWith{true;};

player setVariable ["SFSM_breakingCuffs", true, true];
[] spawn SFSM_fnc_onBreakOutKey;

true;