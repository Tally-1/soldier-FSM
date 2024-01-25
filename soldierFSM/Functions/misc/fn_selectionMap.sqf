// The available LODS for this check, fireGeometry is good for buildings.
// [
//    "Memory",
//    "Geometry",
//    "FireGeometry",
//    "LandContact",
//    "HitPoints",
//    "ViewGeometry"
// ];
params[ 
   ["_object",  nil,      [objNull]],
   ["_posOnly", true,        [true]],
   ["_posASL",  false,       [true]],
   ["_LOD",   "FireGeometry",  [""]]   
];

private _namePos = (_object selectionNames _LOD) apply {
   [([_object, _x] call SFSM_fnc_selectionPos), _x]
};

if(_posOnly)exitWith{
   (_namePos apply {_x#1})
};

_namePos;