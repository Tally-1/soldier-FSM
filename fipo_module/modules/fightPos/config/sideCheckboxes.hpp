class allowEast : Checkbox
{
    property     = "SFSM_FIPO_allowEast";
    displayName  = "Allow OPFOR";
    tooltip      = "If checked this position can be occupied by OPFOR";
    defaultValue = "true";
};

class allowIndependent : Checkbox
{
    property     = "SFSM_FIPO_allowIndependent";
    displayName  = "Allow Independent";
    tooltip      = "If checked this position can be occupied by Independent";
    defaultValue = "true";
};

class allowWest : Checkbox
{
    property     = "SFSM_FIPO_allowWest";
    displayName  = "Allow BLUFOR";
    tooltip      = "If checked this position can be occupied by BLUFOR";
    defaultValue = "true";
};