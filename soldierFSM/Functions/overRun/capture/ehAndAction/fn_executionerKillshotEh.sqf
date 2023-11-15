params["_executioner"];
_executioner addEventHandler ["Fired", {
	params [
		"_executioner", 
		"_weapon", 
		"_muzzle", 
		"_mode", 
		"_ammo", 
		"_magazine",
		"_projectile", 
		"_gunner"
	];

	private _victim        = _executioner getVariable "SFSM_myExecVictim";
	private _projectilePos = getPosATLVisual _projectile;
	private _headPos       = [_victim, "head"] call SFSM_fnc_selectionPos;
	private _headPosASL    = ATLToASL _headPos;
	private _velocityMS    = velocityModelSpace _projectile;
	private _dirUp         = [(vectorDir _projectile), (vectorUp _projectile)];
	private _newProjectile = createVehicle ["B_127x108_Ball", _projectilePos]; 
	
	_newProjectile setVectorDirAndUp _dirUp;
	_newProjectile setVelocityModelSpace _velocityMS;
	_newProjectile setShotParents (getShotParents _projectile);

	[_projectile, _headPos] call SFSM_fnc_setDirAndPitchToPos;
    _projectile setVelocityModelSpace _velocityMS;

}];