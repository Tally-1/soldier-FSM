class SFSM_FIPO : Module_F
{
    #include "header.hpp"

    // class AttributeValues
    // {
    //     size3[]={5,5,-1};
    //     isRectangle=0;
    // };

    // Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
    class Attributes : AttributesBase
    {

        #include "indicatorCheckBox.hpp"
        #include "sideCheckboxes.hpp"
        #include "stances\allStances.hpp"
        #include "typeCheckBoxes.hpp"
        #include "sectors\rightFlank.hpp"
        #include "sectors\leftFlank.hpp"
        #include "overrun\overrun.hpp"
        #include "fubarDisable.hpp"
        #include "hitAndRun.hpp"
        #include "sectors\dynamicFIPO.hpp"
        #include "suppression.hpp"

        class ModuleDescription : ModuleDescription{};
    };

    #include "description.hpp"
};