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
    // Base class templates
    // class Default; // Empty template with pre-defined width and single line height
    // class Title: Default
    // {
    //   class Controls
    //   {
    //     class Title;
    //   };
    // };
    // class Attributes
    // {
    //     // Base class templates
    //     class Default; // Empty template with pre-defined width and single line height
    //     class Title: Default
    //     {
    //         class Controls
    //         {
    //             class Title;
    //         };
    //     };

    //     class DMOD_TimeMultiplier: Title
    //     {
    //         attributeLoad = "[_this, _value] call DMOD_fnc_slider_onAttributeLoad";
    //         attributeSave = "_this call DMOD_fnc_slider_onAttributeSave";
    //         class Controls: Controls
    //         {
    //             class Title: Title {};
    //             class Value: ctrlXSliderH
    //             {
    //             idc = 100;
    //             x = ATTRIBUTE_TITLE_W * GRID_W;
    //             w = (ATTRIBUTE_CONTENT_W - EDIT_W) * GRID_W;
    //             h = CTRL_DEFAULT_H;
    //             sliderPosition = 10;
    //             sliderRange[] = {1, 120};
    //             sliderStep = 1;
    //             };
                
    //             class Edit: ctrlEdit
    //             {
    //             idc = 101;
    //             x = (ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - EDIT_W) * GRID_W;
    //             w = EDIT_W * GRID_W;
    //             h = CTRL_DEFAULT_H;
    //             };
    //         };
    //     };
    // }
    
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