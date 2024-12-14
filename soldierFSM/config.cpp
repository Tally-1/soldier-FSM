#include "BIS_AddonInfo.hpp"
#include "\soldierFSM\functions\cfgFunctions.hpp"
#include "\soldierFSM\sounds\cfgRadio.hpp"
#include "\soldierFSM\sounds\cfgSounds.hpp"

class CfgPatches
{
	class soldierFSM
	{
		
		name 				= "soldier FSM";
		author 				= "YipMan(design / funds), Jihem(funds & Server), Deebs(design / funds), Blazingfire(funds & Bugtesting), Tally(code)";
		requiredVersion 	= 1.60;
		requiredAddons[] 	= { "A3_Functions_F", "CBA_settings" };
		units[] 			= {};
		weapons[] 			= {};
	};
};


class CfgSurfaces {
	class Default {
		AIAvoidStance = 2;
	};
};


// class Extended_PreInit_EventHandlers {
//     class CBApreInit_SFSM {
//         init = "call compile preprocessFileLineNumbers '\soldierFSM\CBA_Options\main.sqf'";
//     };
// };