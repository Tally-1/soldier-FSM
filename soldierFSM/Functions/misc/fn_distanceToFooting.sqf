params["_object"];
private _ASLpos  = getPosASLVisual _object;
private _results = 
(lineIntersectsSurfaces [
	_ASLpos,                        // StartPos
	_ASLpos vectorAdd [0, 0, -50], //  EndPos          --> All params below this are optional <--
	_object,                      //   ignoreObject 1                                          -default objNull
	objNull,                     //    ignoreObject 2                                          -default objNull
	true,                       //     sortMode (true = nearest first || false = nearest last) -default true
	1,                         //      Max results (-1 = All results)                          -default 1
	"GEOM",                   //       primary LOD to look for intersection.                   -default "VIEW"
	"NONE",                  //        Secondary LOD to look for intersection                  -default "FIRE"
	true                    //         Unique results only                                     -default true
]);

if(_results isEqualTo [])exitWith{-1};

// First result destructured:
_results#0
params [
	"_intersectPosASL",    // Position where line intersects surface
	"_surfaceNormal",     //  Vector normal to the intersected surface
	"_intersectObj",     //   Object the surface belongs to (proxy-object. Ex: The current weapon of a man)
	"_parentObject",    //    Proxy-objects parent. (Ex: The man holding said weapon)- objNull if terrain
	"_selectionNames", //     Array of Strings (Names of the intersected selections) (bones).
	"_pathToBisurf"   //      String - path to intersected surface properties (.bisurf) file.
];

private _distance = _ASLpos distance _intersectPosASL;

_distance;