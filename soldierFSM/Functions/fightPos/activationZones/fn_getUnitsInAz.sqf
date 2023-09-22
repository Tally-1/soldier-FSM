private _entities = (_self get "position") nearEntities (_self get "radius");
private _units = _entities select {[_x] call SFSM_fnc_validAzUnit;};


_units;