params["_fipo"];
private _fireSector = ([_fipo] call FIPO_fnc_fipoSectors)#1;

_fireSector params ["_pos", "_angle", "_width", "_distance"];

private _units = (_pos nearEntities _distance) select {
        (_pos distance2D _x) > 2                  // Exclude units in the actual FIPO
    && {[_fireSector, _x] call SFSM_fnc_inSector //  Exclude units outside the sector
	&& {[_x] call SFSM_fnc_functionalMan}};     //   Exclude unconscious / logics etc
};

_units;