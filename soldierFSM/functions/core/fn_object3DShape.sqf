private _min = false;
params ["_object", "_min"];

private _center     = (boundingCenter _object);
        _center     = [_center, 2] call Tcore_fnc_roundPos;
private _shape        = createHashMap;
private _XYZ         = (boundingBoxReal _object) select 1;
if(_min)then{_XYZ    = (boundingBoxReal _object) select 0};
private _X_Y_Ratio   = 0;
private _zeroDivisor= false;

if(_XYZ select 1 == 0
or _XYZ select 0 == 0)
then{_zeroDivisor = true};

if!(_zeroDivisor)
then{_X_Y_Ratio    = (_XYZ select 1) / (_XYZ select 0)};

_shape set ["width",    [(_XYZ select 0), 1]   call Tcore_fnc_decimals];
_shape set ["length",     [(_XYZ select 1), 1] call Tcore_fnc_decimals];
_shape set ["height",     [(_XYZ select 2), 1] call Tcore_fnc_decimals];
_shape set ["Y to X",     [_X_Y_Ratio, 1]      call Tcore_fnc_decimals];
_shape set ["objCenter",_center];

private _objPosData = [_object, _shape] call Tcore_fnc_objPosData;

{
    _shape set [_x, _y];
} forEach _objPosData;

// _shape set ["objPositions",_objPosData]; 
_shape;