params ["_man"];
private _coverObjects = nearestTerrainObjects 
						[(getPos _man), 
						["TREE", "SMALL TREE", "BUSH", "HOUSE", "ROCK", "ROCKS", "WALL"], 
						30, 
						false, 
						true];

if(_coverObjects isEqualTo []) exitWith {};

private _coverObject = selectRandom _coverObjects;

_coverPos = (getPos _coverObject);

_coverPos