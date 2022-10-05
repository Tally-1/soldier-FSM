params ["_battleField"];

_battlefield set ["currentAction",	"Assigning CQB"];
private _units = missionNamespace getVariable (_battleField get "units");

{
  [_x] call SFSM_fnc_initCQB;
  
} forEach _units;
_battlefield set ["currentAction",	"none"];
true;