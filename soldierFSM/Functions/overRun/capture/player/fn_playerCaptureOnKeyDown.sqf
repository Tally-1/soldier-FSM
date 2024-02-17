params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
if(_key isEqualTo 1)                                 exitWith{false;};
if!(_key in [30,31,32,17])                           exitWith{true;};
if(player getVariable ["SFSM_breakingCuffs", false]) exitWith{true;};

player setVariable ["SFSM_breakingCuffs", true, true];
[] spawn SFSM_fnc_onBreakOutKey;

true;