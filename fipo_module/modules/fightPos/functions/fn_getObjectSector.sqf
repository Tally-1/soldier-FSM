private _offset = 0;
params[
	"_object",   // any object to be used as a starting point for a sector
	"_dir",      // Direction relative to object (0 equals in front of object)
	"_distance", // Distance from object to the end of the sector 
	"_width",    // Degrees of sector.
	"_offset"    // How far in front of the object the startingPos should be
];
private _objPos     = (getPosATLVisual _object);
private _height     = _objPos#2;
private _objDir     = (getDir _object);
private _correction = (_width/2);
private _angle      = [_objDir + _dir, false] call FIPO_fnc_formatDir;

if(_offset > 0)then{
	_objPos = (_objPos getPos [_offset, _objDir]);
};


_objPos = [_objPos#0, _objPos#1, _height];


private _sector = [
    _objPos,
    _angle,
    _width,
    _distance
];

_sector;