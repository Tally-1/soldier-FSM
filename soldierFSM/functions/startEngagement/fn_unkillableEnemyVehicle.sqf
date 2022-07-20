params["_man", "_battleField"];
private _unkillableVehicle = objNull; 
private _enemyVehicles     = [_man, _battleField] call SFSM_fnc_getEnemyVehicles;

if(_enemyVehicles isEqualTo []) exitWith {objNull};

private _highThreatVehicles = [];

{
	private _vehicleData   = [_x] call objScan_fnc_vehicleData;
	private _chassisClass  = (_vehicleData get "chassis") get "chassisID";
	private _weaponClasses = _vehicleData get "weaponTypes";
	private _bestWeapon    = selectMax _weaponClasses;
	private _operational   = ! ([_x] call Tcore_fnc_deadCrew);

	if(_operational
	&&{_bestWeapon >= 3
	&&{_chassisClass >= 1.2}})
	then{_highThreatVehicles pushBackUnique _x};

} forEach _enemyVehicles;


if(_highThreatVehicles isEqualTo []) exitWith {objNull};

_unkillableVehicle = [_man, _highThreatVehicles] call Tcore_fnc_nearestPos;

_unkillableVehicle;