params["_man"];
private _carriedExplosives = [];
{
	if(_x in SFSM_explosives)
	exitWith{_carriedExplosives pushback _x};
	
} forEach backpackItems _man;


_carriedExplosives;