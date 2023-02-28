params["_battlefield"];

//wait for grid to load, so that actions like hiding may be properly executed
private _timer = time +5;
waitUntil
{
	sleep 0.1;
	private _gridLoaded = (_battlefield get "gridLoaded");
	if(isNil "_gridLoaded")	exitWith{true};
	if(_gridLoaded)			exitWith{true};
	if(_timer > time)		exitWith{true};
	false;
};

private _vehicles = missionNamespace getVariable (_battlefield get "vehicles");
{[_x] call SFSM_fnc_updateVehicle;}forEach _vehicles;
//loop through all units in the battle assigning start-battle actions.

private _units = missionNamespace getVariable (_battlefield get "units");
{
	private _group          = group _x;
	private _specialActions = [_x, _battlefield] call SFSM_fnc_specialInitFightActions;
	private _grpCanDodge    = ([_group] call SFSM_fnc_groupCanDodge);
	private _excluded       = _x getVariable ["SFSM_Excluded",false];
	if(_grpCanDodge
	&&{(! _specialActions)
	&&{! _excluded}})
	then{
			private _reacting = [_x, _battleField] call SFSM_fnc_reactToVehicles;
			if!(_reacting)then{ [_x, _battlefield] call SFSM_fnc_fightInitCover};
		};

} forEach _units;

sleep 1;



//wait for the battlefield framework to register all map-objects in the area
waitUntil
{
	sleep 0.5;
	private _terrainLoaded = (_battlefield get "terrainLoaded");
	if(isNil "_terrainLoaded")	exitWith{true};
	if(_terrainLoaded)			exitWith{true};
	false;
};

//heal wounded
// _battlefield set ["currentAction",	"Medical actions"];
// private _script = [_battleField] spawn SFSM_fnc_battleFieldMedical;
// waitUntil {
// 	private _finito = scriptDone _script;
// 	if(isNil "_finito")exitWith{true;};
// 	_finito; 
// };


//update cover-positions
_battlefield set ["currentAction",	"Loading cover positions"];
[_battlefield] call SFSM_fnc_getCoverPositionsLight;

private _loadingTime = time - (_battlefield get "Started");

[["Terrain and coverPositions finished loading in ", _loadingTime, " seconds"]] call SFSM_fnc_debugMessage; 

_battlefield set ["currentAction",	"none"];

//spawn a loop that updates the battlefield-hashmap every 10 seconds(can be changed in init-server)
[_battlefield] spawn SFSM_fnc_battleFieldUpdater;

true;