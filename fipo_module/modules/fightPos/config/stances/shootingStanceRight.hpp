// Module-specific arguments:
class ShootingStanceRight : Combo
{
    property     = "SFSM_FIPO_rightShootingStance";    // Unique property (use "<tag>_<moduleClass>_<attributeClass>" format to ensure that the name is unique)
    displayName  = "Right-hand Shooting stance";       // Argument label
    tooltip      = "Select if and what stance to use to fire at the enemy, leaning to the right. \nSidesteps will be done in the same altitude/stance as the cover position."; // Tooltip description
    typeName     = "NUMBER";                   // Value type, can be "NUMBER", "STRING" or "BOOL"
    defaultValue = "-1";                        // Default attribute value. Warning: This is an expression, and its returned value will be used (50 in this case).

    // Listbox items:
    #include "stancesRight.hpp"
};