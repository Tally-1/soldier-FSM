params["_building", "_excludedSide"];
private _shape = [_building] call Tcore_fnc_object3DShape;
private _size = selectMax [(_shape get "width"),(_shape get "length")];
private _units = (_man nearEntities _size) select {[_x] call SFSM_fnc_isRealMan};

if(!isNil "_side")
then{_units = _units select {side _x != _excludedSide}};

_units