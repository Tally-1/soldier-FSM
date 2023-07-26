// Sector:
// array [
// 	_sector#0  [number,number,number] | The starting position of the sector               |
// 	_sector#1  number(0-360)          | The center cirection of the sector                |
// 	_sector#2  number(0-360)          | The total width of the sector measured in degrees |
// 	_sector#3  number > 1             | The length/diameter of the sector                 |
// ]
// A sector is a "Pizza-slice" of a round area, the diameter of said area is defined by the distance param.
// The width of the "Pizza-slice" is defined in degrees.
// Therefore if a sector has a center direction of 180 degrees and a width of 45 degrees then the sector 
// will be measured as an area between 157.5 and 202.5 degrees in the defined distance from the start-position.

params["_sector"];
private _pos       = _sector#0;

// _dir refers to the center direction of the sector.
private _dir       = _sector#1;

//_deg refers to the total degrees from start to end.
private _deg       = _sector#2;
private _dist      = _sector#3;
private _positions = [_pos];

// The edge of a sector is defined by subtracting half of the width(_deg) from 
// its center direction
private _edgeDir   = _dir-(_deg/2);
private _increment = _deg/10;

for "_i" from 0 to 10 do {
	private _edgePos = [_pos, _edgeDir, _dist, 1.5] call SFSM_fnc_sinCosPos2;
	_positions pushBack _edgePos;
	_edgeDir=_edgeDir+_increment;
};

_positions;