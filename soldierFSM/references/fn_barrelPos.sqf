onEachFrame {
	private _weapon = currentWeapon player;
	if (_weapon == "") exitWith {};

	// update weapon info upon weapon switch
	if (_weapon != player getVariable ["last_weapon", "?"]) then
	{
		private _cfg = configFile >> "CfgWeapons" >> _weapon;
		private _model = getText(_cfg >> "model");
		private _simpleObject = createSimpleObject [_model, [0,0,0], true];
		private _offset = _simpleObject selectionPosition [getText (_cfg >> "muzzlePos"), "memory"];
		_offset = _offset apply { [_x] };
		deleteVehicle _simpleObject;
		player setVariable ["offset", _offset];
		player setVariable ["last_weapon", _weapon];
		player setVariable ["proxy",
			[
				"proxy:\a3\characters_f\proxies\pistol.001",
				"proxy:\a3\characters_f\proxies\weapon.001",
				"proxy:\a3\characters_f\proxies\launcher.001",
				"proxy:\a3\characters_f\proxies\binoculars.001"
			] select (([1, 4, 4096] find getNumber (_cfg >> "type")) + 1)
		];
	};

	_offset = player getVariable ["offset", []];
	private _proxy = player getVariable ["proxy", ""];
	// using LOD resolution 1 (and lod index 0) - this is not always reliable
	// you should manually check allLODs and find the most suitable LOD (smallest res LOD usually has the best accuracy, but it might be slow too)
	player selectionVectorDirAndUp [_proxy, 1] params ["_vy", "_vz"];
	private _pos = selectionPosition [player, _proxy, 0];
	private _vx = _vy vectorCrossProduct _vz;

	private _mat = matrixTranspose [_vx, _vy, _vz];
	_pos = _pos vectorAdd flatten (_mat matrixMultiply _offset);

	private _p1 = player modelToWorldVisualWorld _pos;
	private _p2 = _p1 vectorAdd (player vectorModelToWorldVisual (_vx vectorMultiply -1000));
	drawLine3D [ASLToAGL _p1, ASLToAGL _p2, [1,0,0,1]];
};