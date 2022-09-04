private _radius = 30;
params ["_man", "_radius"];
private _coverObjects = nearestTerrainObjects 
						[(getPos _man), 
						["TREE", "SMALL TREE", "BUSH", "HOUSE", "ROCK", "ROCKS", "WALL"], 
						_radius, 
						false, 
						true];

if(_coverObjects isEqualTo []) exitWith {};

_coverObjects deleteAt (_coverObjects findIf {isHidden _x});
private _coverObject = selectRandom _coverObjects;

_coverPos = (getPos _coverObject);

_coverPos