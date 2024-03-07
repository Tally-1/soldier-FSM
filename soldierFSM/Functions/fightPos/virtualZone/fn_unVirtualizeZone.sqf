private _fipos       = [];
private _allAZs        = [];

_self set ["active", true];

{
    private _fipo = [_x] call SFSM_fnc_spawnVzFipo;
	private _AZs  = _x get "activationZones";

    _fipos pushBackUnique _fipo;

	if(_AZs isNotEqualTo [])then{_allAZs insert [0,_AZs,true]};

} forEach (_self get "virtualFipos");

if(canSuspend)
then{[_fipos] call SFSM_fnc_initVzFipos}
else{[_fipos] spawn SFSM_fnc_initVzFipos};

{[_x] call SFSM_fnc_initAz} forEach _allAZs;

_self set ["physicalFipos", _fipos];
_self set ["virtualFipos",      []];


true;