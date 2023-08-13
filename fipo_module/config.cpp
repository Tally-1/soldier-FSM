#include "BIS_AddonInfo.hpp"
#include "config\defines.hpp"
// #include "config\defineCtrls.hpp"
#include "config\cfgVehicles.hpp"
#include "config\cfgFunctions.hpp"


class CfgPatches
{
    class SFSM_fipo
    {
        units[] = {"FIPO_Module"};
        requiredVersion = 1.0;
        requiredAddons[] = {"A3_Modules_F"};
    };

    class SFSM_traits
    {
        units[] = {"SFSM_traitsModule"};
        requiredVersion = 1.0;
        requiredAddons[] = {"A3_Modules_F"};
    };
};

class CfgFactionClasses
{
    class NO_CATEGORY;
    class SFSM_modules: NO_CATEGORY
    {
        displayName = "DCO Soldier FSM";
    };
};

class Cfg3DEN
{
        
    class EventHandlers
    {
        class mySection
        {
            OnMissionNew        = "[] call FIPO_fnc_fipo3D";
            OnMissionLoad       = "[] call  FIPO_fnc_removeGarbage; [] call FIPO_fnc_fipo3D";
            OnMissionPreviewEnd = "[] spawn FIPO_fnc_removeGarbage; [] call FIPO_fnc_fipo3D";
            OnMissionPreview    = "[] call  FIPO_fnc_removeGarbage;";
        };
    };
};