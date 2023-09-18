class activatedByEast : Checkbox
{
    property     = "SFSM_AZ_activatedByEast";
    displayName  = "Activated by OPFOR";
    tooltip      = "Synced fighting positions will be activated by OPFOR forces present in this zone";
    defaultValue = "true";
};

class activatedByIndependent : Checkbox
{
    property     = "SFSM_AZ_activatedByIndependent";
    displayName  = "Activated by Independent";
    tooltip      = "Synced fighting positions will be activated by Independent forces present in this zone";
    defaultValue = "true";
};

class activatedByWest : Checkbox
{
    property     = "SFSM_AZ_activatedByWest";
    displayName  = "Activated by BLUFOR";
    tooltip      = "Synced fighting positions will be activated by BLUFOR forces present in this zone";
    defaultValue = "true";
};