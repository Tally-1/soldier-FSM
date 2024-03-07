private _defaultSides = [east,west,independent];
params[
    ["_module",       nil,      [objNull]],
    ["_returnSides",  false,      [false]],
	["_allowedSides", _defaultSides, [[]]]
];
private _area  = [_module] call SFSM_fnc_getAzArea; _area 
params ["_center", "_a", "_b", "_angle", "_isRectangle", "_c"];
private _radius = selectMax [_a, _b, _c];

private _units = _center nearEntities ["land", _radius] select {
    _x inArea _area                    &&
    {([_x] call SFSM_fnc_functionalMan ||
    {[_x] call SFSM_fnc_validVehicle})}
};

if(_returnSides isEqualTo false)exitWith{_units;};

private _sidesPresent = [_units, _allowedSides] call SFSM_fnc_sidesFromObjArr;

_sidesPresent;