params["_object"];
private _typeName    = [_object] call Tcore_fnc_simpleObjectType;
private _objectShape = [_object] call Tcore_fnc_object3DShape;
private _height      = _objectShape get "height";
private _excluded = false;

if (_height < 0.4)  exitwith{true};
if (_typeName == "")exitWith{true};

private _excludedTypes = [	"setbig", 
							"setsmall", 
							"neriumo2d", 
							"chair", 
							"fence",
							"rowboat",
							"arundod",
							"cages",
							"bench",
							"dangerbend",
							"canisterplastic",
							"lamp",
							"sign",
							"gate",
							"sunshade",
							"basket",
							"swing",
							"water",
							"campingtable",
							"pavement",
							"coil",
							"pallet",
							"crates",
							"roof",
							"feed",
							"atm_0",
							"sacks_heap_f",
							"kiosk_papers_f",
							"pole",
							"goal",
							"calvary",
							"tbox",
							"bucket",
							"slide",
							"garbage_line_f",
							"bluntstones_erosion",
							"vergepost_f",
							"ficusc2d",
							"slums01_8m",
							"slums01_pole",
							"campingchair",
							"tableplastic",
							"garbagebin_01"
						];

{
	
	if(_x in _typeName) 
	exitWith {_excluded = true};

} forEach _excludedTypes;


_excluded