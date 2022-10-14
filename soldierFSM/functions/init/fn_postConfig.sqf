// This file contains settings and global variables that I do not want the end-user to touch.

missionNamespace setVariable ["SFSM_Battles",         createHashmap, true];
missionNamespace setVariable ["SFSM_debugMarkers",    [],            true];
missionNamespace setVariable ["SFSM_TaskCycleTimer",  10, 	         true];
missionNamespace setVariable ["SFSM_TestMode", 		  false, 	     true];
missionNamespace setVariable ["SFSM_customEH_Timer",  0.2, 	         true];


//variables used in the sound reaction / bulletImpact functions
SFSM_lastShotFired     = -300;
SFSM_lastSoundCheck    = -300;
SFSM_lastImpactHandler = -300;
SFSM_lastCrater        = -300;

//How often the battlefield-data is updated
SFSM_BattleUpdateSec = 10;

//types of trees, simple way of distinguishing between hard and soft cover
SFSM_treeTypes = [
					"t_ficusb1s_f",
					"b_ficusc1s_f",
					"t_pinuss1s_f",
					"t_pinuss2s_b_f",
					"t_pinuss2s_f",
					"t_phoenixc1s_f",
					"b_ficusc2s_f",
					"b_neriumo2s_f",
					"t_populusn3s_f",
					"b_neriumo2s_white_f",
					"t_phoenixc3s_f",
					"t_ficusb2s_f",
					"t_oleae1s_f"
				];

//used when a "light areaScan is needed"
SFSM_lightScanTypes=[
					"BUSH",
					"HOUSE",
					"ROCK",
					"ROCKS",
					"RUIN",
					"SMALL TREE",
					"TREE",
					"WALL"
				];
SFSM_excludedMapObjs = [
    'cargo_addon01_v1_f',
    "setbig", 
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

//deactivate group-reset on vehicle FSM
if(!isNil "DCOnoGroupReset")
then{
		missionNamespace setVariable ["DCOnoGroupReset", true, true];
		"DCO soldier FSM deactivated group-reset for DCO vehicle FSM" call dbgmsg;
	};

//logic-side is causing issues, setting it as friendly to all.
{
	_x setFriend [sideLogic, 1];
	sideLogic setFriend [_x, 1];

} forEach [east, west, independent];