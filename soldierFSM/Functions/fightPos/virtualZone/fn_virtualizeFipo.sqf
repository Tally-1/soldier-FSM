params[
	["_fipo", nil, [objNull]]
];
private _data = [_fipo] call SFSM_fnc_hashAllObjVars;
private _man  = [_fipo] call SFSM_fnc_getFipoMan;
private _AZs  = (synchronizedObjects _fipo) select {_x isKindOf "SFSM_AZ"};

_data set ["activationZones", _AZs];

if	(alive _man)
then{[_man] call SFSM_fnc_getOutFipo;};

SFSM_fipositions deleteAt (SFSM_fipositions find _fipo);
SFSM_allFipos    deleteAt (SFSM_allFipos find _fipo);

deleteVehicle _fipo;

_data;