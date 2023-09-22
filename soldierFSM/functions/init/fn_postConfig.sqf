// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Settings and global variables that I do not want the end-user to touch.
missionNamespace setVariable ["SFSM_Battles",         createHashmap, true];
missionNamespace setVariable ["SFSM_debugMarkers",    [],            true];
missionNamespace setVariable ["SFSM_TaskCycleTimer",  10,            true];
missionNamespace setVariable ["SFSM_TestMode",        false,         true];
missionNamespace setVariable ["SFSM_customEH_Timer",  0.2,           true];


//variables used in the sound reaction / bulletImpact /sprint functions
SFSM_lastShotFired      = -300;
SFSM_lastSoundCheck     = -300;
SFSM_lastImpactHandler  = -300;
SFSM_lastCrater         = -300;
SFSM_lastSprintLosCheck = -300;


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
//map objects that does not work for using as cover
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

//explosive-types that can be used to blow up buildings
SFSM_explosives = [
  "SatchelCharge_Remote_Mag",
  "IEDUrbanBig_Remote_Mag",
  "IEDLandSmall_Remote_Mag",
  "DemoCharge_Remote_Mag",
  "ClaymoreDirectionalMine_Remote_Mag",
  "IEDLandBig_Remote_Mag",
  "IEDUrbanSmall_Remote_Mag"
];

//Vehicles that will be used by the hijack feature
SFSM_hijackVehicleTypes = [
  "car (AA-AT combo launcher)",
    "MRAP (HMG)",
    "car (HMG)",
    "MRAP (GMG)",
    "car (GMG)",
    "car (Rocket launcher)",
    "BTR",
    "Tank",
    "light armor (HMG)",
    "APC",
    "IFV",
    "heavy armor (Artillery)",
    "Tank destroyer",
    "Armored Anti-Air"];

SFSM_hijackArmourTypes = [
    "Tank",
    "light armor (HMG)",
    "APC",
    "IFV",
    "heavy armor (Artillery)",
    "Tank destroyer",
    "Armored Anti-Air"
];

SFSM_fipoActions = [
	"Idle",
	"peeking",
	"Peeking", 
	"In cover",
	"Moving to fighting position",
	"Dodging to FIPO",
    "Engaging target",
    "Suppressing enemy"
] apply {toLowerANSI _x;};

//all AI abilities that can be disabled using the "disableAI" command.
missionNamespace setVariable ["SFSM_aiAbilities", 
[
	"AIMINGERROR",
	"ANIM",
	"AUTOCOMBAT",
	"AUTOTARGET",
	"CHECKVISIBLE",
	"COVER",
	"FSM",
	"LIGHTS",
	"MINEDETECTION",
	"MOVE",
	"NVG",
	"PATH",
	"RADIOPROTOCOL",
	"SUPPRESSION",
	"TARGET",
	"TEAMSWITCH",
	"WEAPONAIM"
], true];

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

//checking if ACE is loaded
private _addons  = [] call SFSM_fnc_loadedAddons;
SFSM_aceLoaded   = "@ace" in _addons;

// getting all fipos stored in editor
SFSM_fipositions     = [];// entities "logic" select {typeOf _x isEqualTo "SFSM_FIPO"};
SFSM_activationZones = [];// entities "logic" select {typeOf _x isEqualTo "SFSM_FIPO"};
SFSM_allFipos        = [];
// {
//     if(typeOf _x isEqualTo "SFSM_FIPO")
//     then{SFSM_fipositions pushBack _x};

//     if(typeOf _x isEqualTo "SFSM_AZ")
//     then{SFSM_activationZones pushBack _x};
    
// } forEach (entities "logic");

SFSM_sprinters   = []; //simultaneous sprinters, used to cap the amount
SFSM_cleanupObjs = []; //Objects programmed for deletion.





if(!isNil "Tally_Dev"
&&{Tally_Dev})
then{execVm "devFile.sqf";};