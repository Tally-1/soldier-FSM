params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
if!(_key in [30,31,32,17])exitWith{false;};

player setVariable ["SFSM_breakingCuffs", false, true];

true;