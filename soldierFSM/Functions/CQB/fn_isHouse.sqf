params[ 
	["_building",    nil, [objNull]],
    ["_ignoreAlt",   false, [false]],
	["_minPosCount", 3,         [0]]
];
if!(_building isKindOf "House")exitWith{false;};

private _posCount = count (_building buildingPos -1);
if(_posCount < _minPosCount)exitWith{false;};

if(_ignoreAlt)exitWith{true;};

private _buildingAltitude = (getPosATLVisual _building)#2;
if(_buildingAltitude < (0-5))exitWith{false;};

true;