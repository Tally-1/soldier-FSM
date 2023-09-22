private _fipos           = [];
private _activationZones = [];
private _azFipos         = [];

{
    if(typeOf _x isEqualTo "SFSM_FIPO")
    then{_fipos pushBack _x};

    if(typeOf _x isEqualTo "SFSM_AZ")then{
    private _connectedFipos = [_x] call SFSM_fnc_getAzFipos;
    _azFipos append _connectedFipos;
    _activationZones pushBack _x;
    };

} forEach (entities "logic");
 
{[_x] call SFSM_fnc_initFipo} forEach _fipos;

SFSM_activationZones = [_activationZones] call SFSM_fnc_initActivationZones;
SFSM_fipositions     = _fipos select  {(_x in _azFipos) isEqualTo false;};
SFSM_azFIPOs         = _azFipos apply {[_x] call SFSM_fnc_initAzFipo;};
SFSM_activeAzFipos   = [];
SFSM_allFipos        = _fipos;


true;