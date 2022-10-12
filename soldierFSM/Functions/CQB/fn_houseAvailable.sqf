params ['_building'];
private _occupants = [_building] call SFSM_fnc_unitsInBuilding;
private _positions = [_building] call BIS_fnc_buildingPositions;
if(count _positions < 3)exitwith{false;};
_positions = _positions select SFSM_fnc_CQBcoverPosFilter;
if(count _positions == 0)exitwith{false;};

private _available = ((count _occupants)<(count _positions));
_available;