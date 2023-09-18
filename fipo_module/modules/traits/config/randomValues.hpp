class randomize_values : Checkbox
{
    property     = "randomize_values";
    displayName  = "Randomize Values";
    tooltip      = "If checked a random value will be added to the settings above.\n The range of said random value is defined using the sider below.";
    defaultValue = "false";
};

class random_skill_value : Edit
{
    property     = "random_skill_value";
    displayName  = "Random Skill Value";
    tooltip      = "If values are randomised this slider will define the maximum range of the original value.\n EX: if Courage = 50% & Random value = 10% then Courage will be between 45% and 55%.";
    control      = "Slider";
    typeName     = "NUMBER";
    defaultValue = "0.1";
};