// Sector:
// array [
// 	"_startPos",  [number,number,number] | The starting point of the sector                  |
// 	"_direction", number(0-360)          | The center cirection of the sector                |
// 	"_degrees",   number(0-360)          | The total width of the sector measured in degrees |
// 	"_distance"   number > 1             | The length/diameter of the sector                 |
// ]
// A sector is a "Pizza-slice" of a round area, the diameter of said area is defined by the distance param.
// The width of the "Pizza-slice" is defined in degrees.
// Hence if you want a sector with a center direction of 180 degrees and a width of 45 degrees then the sector 
// will be measured as an area between 157.5 and 202.5 degrees in the defined distance from the start-position.
params[   
	"_sector", 
	"_object"  // any object OR position 
];
if!([_sector] call SFSM_fnc_validSector)exitWith{"invalid sector" call dbgMsg; nil;};
private _pos      = _sector#0;
private _dir      = _sector#1;
private _deg      = _sector#2;
private _dist     = _sector#3;
private _dirToObj = _pos getDir _object;

if(_pos distance2D _object > _dist)                       exitwith{false;};
if([_dir, _dirToObj, (_deg/2)] call SFSM_fnc_inDirRange)  exitwith{true; };

false;