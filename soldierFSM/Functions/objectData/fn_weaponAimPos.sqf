/*
This is essentially a copy of a function found at:
https://community.bistudio.com/wiki/selectionVectorDirAndUp
*/

params ["_man", "_distance"];
private _weapon = currentWeapon _man;
if (_weapon == "") exitWith {};

// update weapon info upon weapon switch
if (_weapon != _man getVariable ["last_weapon", "?"]) then
{
	private _cfg = configFile >> "CfgWeapons" >> _weapon;
	private _model = getText(_cfg >> "model");

	private _simpleObject = createSimpleObject [_model, [0,0,0], true];
	private _offset = _simpleObject selectionPosition [getText (_cfg >> "muzzlePos"), "memory"];
	
	_offset = _offset apply { [_x] };
	deleteVehicle _simpleObject;
	_man setVariable ["offset", _offset];
	_man setVariable ["last_weapon", _weapon];
	_man setVariable ["proxy",
	[
		"proxy:\a3\characters_f\proxies\pistol.001",
		"proxy:\a3\characters_f\proxies\weapon.001",
		"proxy:\a3\characters_f\proxies\launcher.001",
		"proxy:\a3\characters_f\proxies\binoculars.001"
	] select (([1, 4, 4096] find getNumber (_cfg >> "type")) + 1)
];
};

_offset = _man getVariable ["offset", []];
private _proxy = _man getVariable ["proxy", ""];
// using LOD resolution 1 (and lod index 0) - this is not always reliable
// you should manually check allLODs and find the most suitable LOD (smallest res LOD usually has the best accuracy, but it might be slow too)
_man selectionVectorDirAndUp [_proxy, 1] params ["_vy", "_vz"];
private _pos = selectionPosition [_man, _proxy, 0];
private _vx = _vy vectorCrossProduct _vz;

private _mat = matrixTranspose [_vx, _vy, _vz];
_pos = _pos vectorAdd flatten (_mat matrixMultiply _offset);

private _barrel = _man modelToWorldVisualWorld _pos;
private _aimPos = _barrel vectorAdd (_man vectorModelToWorldVisual (_vx vectorMultiply 0-_distance));

[_barrel, _aimPos];