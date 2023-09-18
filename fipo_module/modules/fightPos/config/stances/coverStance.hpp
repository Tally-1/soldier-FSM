// Module-specific arguments:
class CoverStance : Combo
{
    property     = "SFSM_FIPO_coverStance";    // Unique property (use "<tag>_<moduleClass>_<attributeClass>" format to ensure that the name is unique)
    displayName  = "Cover stance";            // Argument label
    tooltip      = "Select the stance used to hide from enemy fire";// Tooltip description
    typeName     = "NUMBER";                   // Value type, can be "NUMBER", "STRING" or "BOOL"
    defaultValue = "1";                        // Default attribute value. Warning: This is an expression, and its returned value will be used (50 in this case).

    // Listbox items:
    #include "stancesCover.hpp"
};