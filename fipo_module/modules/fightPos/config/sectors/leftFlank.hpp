class leftFlank : Combo
{
    property     = "SFSM_FIPO_leftFlank";
    displayName  = "LEFT flank";
    tooltip      = "The position is abandoned if a known enemy is on the left flank.";
    typeName     = "NUMBER";
    defaultValue = "-1";
    
    // Listbox items:
    class Values
    {
        #include "disabledDistance.hpp"
        #include "distances.hpp"
    };
};

class SFSM_leftFlankWidth : Edit
{
    property     = "SFSM_FIPO_leftFlankWidth";
    displayName  = "LEFT flank width";
    tooltip      = "Defines a percentage of 0-180 degrees on the left flank";
    control      = "Slider";
    typeName     = "NUMBER";
    // defaultValue = "0.55";
    defaultValue = "_this getVariable ['SFSM_leftFlankWidth', 0.55]";
};