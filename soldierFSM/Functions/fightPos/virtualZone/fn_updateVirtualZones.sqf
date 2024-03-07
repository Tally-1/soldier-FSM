{
    private _zoneData = _x getVariable "SFSM_vzData";
    _zoneData call ["toggleZone"];

} forEach (entities "SFSM_VZ");

true;