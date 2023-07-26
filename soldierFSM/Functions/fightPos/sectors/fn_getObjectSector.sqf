private _offset = 0;
params[
	"_object",   // any object to be used as a starting point for a sector
	"_dir",      // Direction relative to object (0 equals in front of object)
	"_distance", // Distance from object to the end of the sector 
	"_width",    // Degrees of sector.
	"_offset"    // How far in front of the object the startingPos should be
];
private _objPos     = (getPos _object);
private _objDir     = (getDir _object);
private _correction = (_width/2);
private _angle      = [_objDir + _dir, false] call Tcore_fnc_formatDir;//+_correction;

if(_offset > 0)then{
	_objPos = [_objPos, _objDir, _offset] call SFSM_fnc_sinCosPos2;
};


private _sector = [
    _objPos,
    _angle,
    _width,
    _distance
];

_sector;