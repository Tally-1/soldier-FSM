params["_man", "_enemyVehicle"];

private _hiddenPositions = [_enemyVehicle, "hiddenPos"] call SFSM_fnc_vehicleData;
if(isNil '_hiddenPositions')exitWith{"Hidden Positions undefined" call dbgmsg};
if(typeName _hiddenPositions != 'ARRAY')exitWith{"Wrong data on hidden Positions." call dbgmsg};
if(_hiddenPositions isEqualTo [])exitWith{"No hidden Positions found" call dbgmsg};

//selects positions that are closer to the man than the vehicle
//
private _filter = {
	if(typeName _x != 'ARRAY')exitWith{false;};
	
	private _manToVehDist = _enemyVehicle distance2D _man;
	private _manToPosDist = _x distance2D _man;
	private _vehToPosDist = _x distance2D _enemyVehicle;

	(_vehToPosDist > _manToPosDist
	&&{_manToVehDist > _vehToPosDist
	&&{_manToPosDist < 200}})
};
private _finalSelection = _hiddenPositions select _filter;
if(_finalSelection isEqualTo [])exitWith{"final selection empty" call dbgmsg};

private _targetPosition = ([_finalSelection, [], {_man distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;

_targetPosition;