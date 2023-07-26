class hitAndRun : Checkbox
{
    property     = "SFSM_FIPO_hitAndRun";
    displayName  = "Hit and run";
    tooltip      = "The position will be abandoned once the soldier has fired the max amount shots allowed, or has timed out. It will be available again after a cooldown.";
    defaultValue = "false";
};

class hitAndRunCoolDown: Edit
{
    property     = "SFSM_FIPO_hitAndRunCoolDown";
    displayName  = "Hit And Run CoolDown";
    tooltip      = "How long from the position is abandoned until it can be used again. (Only valid when ''Hit and Run'' is activated!)";
    control      = "SliderTime";
    typeName     = "NUMBER";
    defaultValue = "20";
};

class hitAndRunTimeOut: Edit
{
    property     = "SFSM_FIPO_hitAndRunTimeOut";
    displayName  = "Hit And Run TimeOut";
    tooltip      = "How long until the position is abandoned regardless of shots fired. (Only valid when ''Hit and Run'' is activated!)";
    control      = "SliderTime";
    typeName     = "NUMBER";
    defaultValue = "60";
};

class hitAndRunMaxShots: Edit
{
    property     = "SFSM_FIPO_maxShots";
    displayName  = "Hit And Run max shots";
    tooltip      = "Once this amount of shots is fired the position is abandoned.         (Only valid when ''Hit and Run'' is activated!)";
    typeName     = "NUMBER";
    defaultValue = "10";
};