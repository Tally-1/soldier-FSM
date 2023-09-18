class type : Combo
{
    property     = "SFSM_AZ_type";    // Unique property (use "<tag>_<moduleClass>_<attributeClass>" format to ensure that the name is unique)
    displayName  = "Activation-Zone type";   // Argument label
    tooltip      = "Select what type of activation zone this is. Read module description for more info.";// Tooltip description
    typeName     = "NUMBER";                   // Value type, can be "NUMBER", "STRING" or "BOOL"
    defaultValue = "0";                        // Default attribute value. Warning: This is an expression, and its returned value will be used (50 in this case).

    // Listbox items:
    class Values
    {
        class PL
        {
            name = "Fire-Sector: Activates FIPO when enemies are present";
            value = 0;
        };

        class PM
        {
            name = "Flank:         Deactivates FIPO when enemies are present";
            value = 1;
        };
    };
};