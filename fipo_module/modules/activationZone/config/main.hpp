class SFSM_AZ : Module_F
{
    #include "header.hpp"

    class AttributeValues
    {
        size3[]={25,50,20};
        isRectangle=1;
    };

    // Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
    class Attributes : AttributesBase
    {
        #include "settings\Aztype.hpp"
        #include "settings\AzActivationSides.hpp"
        #include "settings\AzActivationKnowledge.hpp"

        class ModuleDescription : ModuleDescription{};
    };

    #include "description.hpp"
};