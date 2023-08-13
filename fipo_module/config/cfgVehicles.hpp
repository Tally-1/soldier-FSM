class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			
			class Default;
			class Edit;					// Default edit box (i.e. text input field)
			class Combo;				// Default combo box (i.e. drop-down menu)
			class Checkbox;				// Default checkbox (returned value is Boolean)
			class CheckboxNumber;		// Default checkbox (returned value is Number)
			class Slider;               // Grabbed from the CFG-3DEN (seems to work, % type slider)
			class SliderDistance;       // 
			class SliderTime;           // 
			class ModuleDescription;	// Module description
			class Units;				// Selection of units on which the module is applied
			class EditArray;            //
			class EditMulti3;           //
			
		};

		// Description base classes (for more information see below):
		class ModuleDescription
		{
			class AnyBrain;
		};
	};

	#include "..\modules\fightPos\config\main.hpp"
	#include "..\modules\traits\config\main.hpp"
};