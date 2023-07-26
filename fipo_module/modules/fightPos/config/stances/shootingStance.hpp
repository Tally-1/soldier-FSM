// Module-specific arguments:
class ShootingStance : Combo
{
	property     = "SFSM_FIPO_shootingStance";    // Unique property (use "<tag>_<moduleClass>_<attributeClass>" format to ensure that the name is unique)
	displayName  = "Vertical shooting stance";    // Argument label
	tooltip      = "Stance used to fire at the enemy. Should be higher than the cover-stance";// Tooltip description
	typeName     = "NUMBER";                   // Value type, can be "NUMBER", "STRING" or "BOOL"
	defaultValue = "7";                        // Default attribute value. Warning: This is an expression, and its returned value will be used (50 in this case).

	// Listbox items:
	#include "stanceValues.hpp"
};