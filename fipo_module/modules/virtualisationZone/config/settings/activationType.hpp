class  : Edit
{
    displayName  = "Activation type";
    tooltip      = "How much knowledge does the defending side need of the enemies in this sector for it to become active.\nAt 37.5% The unit knows it is enemy.";
    control      = "Slider";
    typeName     = "NUMBER";
    defaultValue = "0";
};

class activationType : Combo
{
    property     = "SFSM_FIPO_activationType";
    displayName  = "Activation Type";
    tooltip      = "Select how the module will be activated.";
    typeName     = "NUMBER";
    defaultValue = "2";
    
    // Listbox items:
    class Values
    {
        class one
        {
            name = "One side present";
            value = 1;
        };

        class two
        {
            name = "Two sides present";
            value = 2;
        };

        class overTwo
        {
            name = "More than two sides present";
            value = 3;
        };

        class battle
        {
            name = "Only active during battle";
            value = 4;
        };
    };
};