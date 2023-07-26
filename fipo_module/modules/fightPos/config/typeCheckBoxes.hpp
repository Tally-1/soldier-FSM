class allowSQL : Checkbox
{
    property     = "SFSM_FIPO_allowSquadLeader";
    displayName  = "Allow Squad Leaders";
    tooltip      = "If checked this position can be used by Squad Leaders";
    defaultValue = "true";
};

class allowMED : Checkbox
{
    property     = "SFSM_FIPO_allowMedic";
    displayName  = "Allow Medics";
    tooltip      = "If checked this position can be used by Medics";
    defaultValue = "true";
};

class allowMAR : Checkbox
{
    property     = "SFSM_FIPO_allowMarksman";
    displayName  = "Allow Marksmen";
    tooltip      = "If checked this position can be used by Marksmen / Snipers";
    defaultValue = "true";
};

class allowMGN : Checkbox
{
    property     = "SFSM_FIPO_allowMachineGunner";
    displayName  = "Allow MachineGunners";
    tooltip      = "If checked this position can be used by MachineGunners";
    defaultValue = "true";
};

class allowATS : Checkbox
{
    property     = "SFSM_FIPO_allowAtSpecialist";
    displayName  = "Allow AT-Specialists";
    tooltip      = "If checked this position can be used by AT-Specialists";
    defaultValue = "true";
};