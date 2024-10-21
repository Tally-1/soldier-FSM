private _radius = 30;
params ["_man", "_radius"];
private _coverObjects = nearestTerrainObjects 
                        [
                            (getPos _man), 
                            ["TREE", "SMALL TREE", "BUSH", "HOUSE", "ROCK", "ROCKS", "WALL"], 
                            _radius, 
                            false, 
                            true
                        ]select{!isHidden _x};;

if(_coverObjects isEqualTo []) exitWith {};
private _coverObject = selectRandom _coverObjects;

_coverPos = (getPos _coverObject);

_coverPos