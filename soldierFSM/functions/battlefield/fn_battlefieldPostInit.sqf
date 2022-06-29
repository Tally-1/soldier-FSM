params["_battlefield"];
private _units = missionNamespace getVariable (_battlefield get "units");
{[_x] call SFSM_fnc_fightInitCover} forEach _units;

waitUntil
{
	sleep 0.5;
	private _terrainLoaded = (_battlefield get "terrainLoaded");
	if(isNil "_terrainLoaded")	exitWith{true};
	if(_terrainLoaded)			exitWith{true};
	false;
};

if(isNil "_battlefield")	exitWith{false};

_battlefield set ["currentAction",	"Loading cover positions"];
[_battlefield] call SFSM_fnc_getCoverPositionsLight;

private _loadingTime = time - (_battlefield get "Started");

[["Terrain and coverPositions finished loading in ", _loadingTime, " seconds"]] call SFSM_fnc_debugMessage; 
_battlefield set ["currentAction",	"none"];



[_battlefield] spawn SFSM_fnc_battleFieldUpdater;

{
	waitUntil{sleep 0.1; ([_x, "action"] call SFSM_fnc_unitData) == "none"};

	[_x] call SFSM_fnc_initHunker;
} forEach [_units#1/*, _units#1, _units#2, _units#3*/];




true;