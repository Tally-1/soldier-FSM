class rightFlank : Combo
{
    property     = "SFSM_FIPO_rightFlank";
    displayName  = "RIGHT flank";
    tooltip      = "The position is abandoned if a known enemy is on the right flank";
    typeName     = "NUMBER";
    defaultValue = "-1";

    // Listbox items:
	#include "distances.hpp"
};

class SFSM_rightFlankWidth : Edit
{
    property     = "SFSM_FIPO_rightFlankWidth";
    displayName  = "RIGHT flank width";
    tooltip      = "Defines a percentage of 0-180 degrees on the right flank";
    control      = "Slider";
    typeName     = "NUMBER";
    defaultValue = "0.55";
};