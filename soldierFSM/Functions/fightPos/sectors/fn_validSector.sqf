// Sector:
// array [
// 	_sector#0  [number,number,number] | The starting position of the sector               |
// 	_sector#1  number(0-360)          | The center direction of the sector                |
// 	_sector#2  number(0-360)          | The total width of the sector measured in degrees |
// 	_sector#3  number > 1             | The length/diameter of the sector                 |
// ]
// A sector is a "Pizza-slice" of a round area, the diameter of said area is defined by the distance param.
// The width of the "Pizza-slice" is defined in degrees.
// Hence if you want a sector with a center direction of 180 degrees and a width of 45 degrees then the sector 
// will be measured as an area between 157.5 and 202.5 degrees in the defined distance from the start-position.

params["_sector"];
if(typeName _sector isNotEqualTo "ARRAY") exitWith{false;};
if(count _sector isNotEqualTo 4)          exitWith{false;};
if!(_sector isEqualTypeArray [[],0,0,0])  exitWith{false;};

private _pos  = _sector#0;
private _dir  = _sector#1;
private _deg  = _sector#2;
private _dist = _sector#3;

if(isNil "_pos")                     exitWith{false;};
if!([_pos] call SFSM_fnc_isPosition) exitWith{false;};

if(_dir < 0)   exitWith{false;};
if(_dir > 360) exitWith{false;};
if(_deg < 2)   exitWith{false;};
if(_deg > 360) exitWith{false;};
if(_dist < 5)  exitWith{false;};

true;