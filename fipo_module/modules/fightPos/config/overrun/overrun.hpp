class allowOverrun : Checkbox
{
    property     = "SFSM_FIPO_allowOverrun";
    displayName  = "Allow to be overrun";
    tooltip      = "The position is abandoned If an enemy gets within the ''OverRun Distance'' defined below.";
    defaultValue = "true";
};

class overrunDistance : Combo
{
    property     = "SFSM_FIPO_overrunDistance";
    displayName  = "Overrun Distance";
    tooltip      = "If an enemy is within this distance the position is considered overrun and will be abandoned.\nMake sure that you have allowed it using the Checkbox above.";
    typeName     = "NUMBER";
    defaultValue = "(missionNamespace getVariable ['SFSM_overRunDistance', 40])";

    // Listbox items:
    class Values
    {
        #include "distances.hpp"
    };
};