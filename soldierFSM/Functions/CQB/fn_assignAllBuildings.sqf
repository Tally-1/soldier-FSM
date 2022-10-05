params["_battleField"];
_battlefield set ["currentAction",	"Assigning buildings"];
private _units = missionNamespace getVariable (_battlefield get "units");

{[_x] call SFSM_fnc_assignBuilding;} forEach _units;

_battlefield set ["currentAction",	"none"];

true;