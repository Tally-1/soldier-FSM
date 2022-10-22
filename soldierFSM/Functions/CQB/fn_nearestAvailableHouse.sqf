params ['_pos', '_radius'];
private _buildings = [];
private _battleField = [_pos] call SFSM_fnc_nearestBattle;
private _filter = {(_x distance2D _pos < _radius) && {[_x] call SFSM_fnc_houseAvailable}};

//check if pos is inside a battle.
if(typeName _battleField == "HASHMAP"
&&{_battleField get "terrainLoaded"
&&{(_pos distance2D (_battleField get "center"))<(_battleField get "radius")}})
exitwith{
		  private _allBuildings = (missionNameSpace getVariable (_battleField get "buildings"));
	  	  _buildings = _allBuildings select _filter;
	  	  if(count _buildings < 1)exitwith{};
		  private _nearest = ([_buildings, [], {_pos distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;
		  _nearest;
};
 

private _allBuildings = _pos nearObjects ["house", 20];
_buildings = _allBuildings select _filter;
if(count _buildings < 1)exitwith{};
private _nearest = ([_buildings, [], {_pos distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;
_nearest;