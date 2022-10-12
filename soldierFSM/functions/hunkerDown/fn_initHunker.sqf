params ["_man"];
private _battlefield = [_man] call SFSM_fnc_getBattlefield;
if(isNil "_battlefield")exitWith{false;};
private _action = [_man, "action"] call SFSM_fnc_unitData;
if("hunker" in _action)exitWith{false;};


if((leader (group _man) == _man)
&&{count(units (group _man)) > 1})exitWith{false;};

private _maxDistance    = (_battlefield get "radius")*2;
private _knownEnemies   = [_man, _maxDistance, 'enemies'] call Tcore_Fnc_nearKnownEnemies;
if(count _knownEnemies == 0)exitWith{false;};

private _hunkerObject = [_man, _battlefield] call SFSM_fnc_getHunkerObject;
if(isNull _hunkerObject)exitWith{false;};

private _objData = [_hunkerObject, _battlefield]   call SFSM_fnc_hunkObjHash;
if(isNil "_objData")exitWith{false;};

private _enemyVehicles = [];
private _vehicles = missionNamespace getVariable (_battlefield get "vehicles");
_enemyVehicles = _vehicles select 
		               {((side _x) != (side _man))
		               &&{(!([(side _x), (side _man)] call BIS_fnc_sideIsFriendly))
					   &&{!([_x] call Tcore_fnc_deadCrew)}}};


if(count _enemyVehicles > 0)
exitWith{false;};

[_man, _battlefield, _objData] spawn SFSM_fnc_hunkerFSM;

true;