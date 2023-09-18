class SFSM_traits : Module_F
{
    #include "header.hpp"

    // Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
    class Attributes : AttributesBase
    {
        #include "dropDownSyncTo.hpp"
        #include "excludedCheckBox.hpp"
        
        #include "aimingErrorCheckBox.hpp"
        #include "courage.hpp"
        #include "command.hpp"

        #include "reloadSpeed.hpp"
        
        #include "aimShake.hpp"
        #include "aimSpeed.hpp"
        #include "aimAccuracy.hpp"
        
        #include "spotDistance.hpp"
        #include "spotTime.hpp"
        #include "randomValues.hpp"
        
        class ModuleDescription : ModuleDescription{}; 
    };

    #include "description.hpp"
};

/*
"AIMINGERROR"


"courage"
"aimingAccuracy"
"aimingShake"
"aimingSpeed"
"commanding"
"endurance"
"spotDistance"
"spotTime"
"reloadSpeed"
*/