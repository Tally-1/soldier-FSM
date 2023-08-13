class command : Edit
{
    property     = "command";
    displayName  = "Set command";
    tooltip      = "Sets the soldiers group-leader command-skill. This will affect the behaviour of his subordinates.\n 0% = bad  ||  100% = good";
    control      = "Slider";
    typeName     = "NUMBER";
    defaultValue = "0.50001";
};