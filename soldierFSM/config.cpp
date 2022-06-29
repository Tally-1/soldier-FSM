#include "BIS_AddonInfo.hpp"
#include "\soldierFSM\functions\cfgFunctions.hpp"


class CfgPatches
{
	class soldierFSM
	{
		
		name 				= "soldier FSM";
		author 				= "YipMan, Jihem, Deebs, Tally";
		requiredVersion 	= 1.60;
		requiredAddons[] 	= { "CBA_settings" };
		units[] 			= {};
		weapons[] 			= {};
	};
};


class CfgSurfaces {
	class Default {
		AIAvoidStance = 2;
	};
};


class Extended_PreInit_EventHandlers {
    class CBApreInit_SFSM {
        init = "call compile preprocessFileLineNumbers '\soldierFSM\customCBA.sqf'";
    };
};