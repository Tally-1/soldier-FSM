params ["_battleField"];

_battlefield set ["currentAction",	"Assigning CQB"];
private _units = missionNamespace getVariable (_battleField get "units");

{
  private _script = [_x] spawn SFSM_fnc_initCQB;
  waitUntil{sleep 0.02; scriptDone _script};
  
} forEach _units;
_battlefield set ["currentAction",	"none"];
true;