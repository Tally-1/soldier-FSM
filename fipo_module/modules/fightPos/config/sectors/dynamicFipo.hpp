class dynamicFipo : Checkbox
{
    property     = "SFSM_FIPO_dynamicFipo";
    displayName  = "Dynamic Fighting Position";
    tooltip      = "The position is uesd ONLY when there are enemies within the ''Fire-sector''. All other settings still apply.";
    defaultValue = "false";
};

class fireSectorDistance : Combo
{
    property     = "SFSM_FIPO_fireSectorDistance";
    displayName  = "Fire Sector Distance";
    tooltip      = "Define the Distance of the fire-sector.\n(Only valid when ''Dynamic Fighting Position'' is activated!)\nWill be ignored if this FIPO is synced to a Activation-Zone";
    typeName     = "NUMBER";
    defaultValue = "300";

    // Listbox items:
    class Values
    {
        #include "distances.hpp"
    };
};

class fireSectorWidth : Edit
{
    property     = "SFSM_FIPO_fireSectorWidth";
    displayName  = "Fire Sector Width";
    tooltip      = "Define the width of the fire-sector. A 100% sector equals 180 degrees.\n(Only valid when ''Dynamic Fighting Position'' is activated!)\nWill be ignored if this FIPO is synced to a Activation-Zone";
    control      = "Slider";
    typeName     = "NUMBER";
    defaultValue = "0.5";
};