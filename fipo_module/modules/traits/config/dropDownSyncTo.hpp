// Module-specific arguments:
class TMOD_syncTo : Combo
{
    property     = "TMOD_FIPO_syncTo";      // Unique property (use "<tag>_<moduleClass>_<attributeClass>" format to ensure that the name is unique)
    displayName  = "Apply to";             // Argument label
    tooltip      = "Select who is affected by the settings in this module.\n\nIf side or faction is selected then only the side / faction of one synchronized soldier is used.\n\nTo select multiple sides / factions use more than one module.";// Tooltip description
    typeName     = "STRING";             // Value type, can be "NUMBER", "STRING" or "BOOL"
    defaultValue = """man""";           // Default attribute value. Warning: This is an expression, and its returned value will be used (50 in this case).

    class Values
    {
        // Listbox items:
        class man
        {
            name = "Synchronized soldiers only";
            value = "man";
        };

        class group
        {
            name = "Groups of synchronized soldiers";
            value = "group";
        };

        class faction
        {
            name = "Faction of synchronized soldier";
            value = "faction";
        };

        class side
        {
            name = "Side of synchronized soldier";
            value = "side";
        };
    };
};