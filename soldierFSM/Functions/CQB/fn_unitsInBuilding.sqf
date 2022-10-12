params["_building", "_excludedSide"];
private _shape = [_building] call Tcore_fnc_object3DShape;
private _size = selectMax [(_shape get "width"),(_shape get "length")];
private _units = (_building nearEntities _size) select {[_x] call SFSM_fnc_isRealMan};

if(!isNil "_excludedSide")
then{_units = _units select {side _x != _excludedSide}};

_units