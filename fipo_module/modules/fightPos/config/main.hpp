class SFSM_FIPO : Module_F
{
    #include "header.hpp"

    // Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
    class Attributes : AttributesBase
    {

        #include "indicatorCheckBox.hpp"
        #include "sideCheckboxes.hpp"
        #include "stances\allStances.hpp"
        #include "typeCheckBoxes.hpp"
        #include "flanks\rightFlank.hpp"
        #include "flanks\leftFlank.hpp"
        #include "allowOverrun.hpp"
        #include "fubarDisable.hpp"
        #include "hitAndRun.hpp"
        

        class ModuleDescription : ModuleDescription{}; 

    };

    #include "description.hpp"
};