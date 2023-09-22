params["_activationZone"];
private _azFipos = [];
{
    if(typeOf _x isEqualTo "SFSM_FIPO")then{
        _azFipos pushBack _x;
        _x setVariable ["AZ_FIPO", true, true];
    };
    
} forEach (synchronizedObjects _activationZone);

_azFipos;