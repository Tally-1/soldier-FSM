params ["_object", "_shape"];
private _objData = createHashMap;

private _aslPos  = (getPosASLVisual _object);
private _pos      = ASLToAGL _aslPos;

//rounding the coordinates to a max of 2 decimals.
_pos = [_pos, 2] call Tcore_fnc_roundPos;
private _posFirst = _pos # 0;
private _posSecond = _pos # 1;

private _topPos   =     [_posFirst, 
                         _posSecond, 
                         ((_pos # 2) + (_shape get "height"))];

private _rightPos =     [_posFirst, 
                         (_posSecond), 
                         (getDir _object) + 90, 
                         (_shape get "width")
                        ] call Tcore_fnc_sinCosPos;

private _leftPos =         [_posFirst, 
                         (_posSecond), 
                         (getDir _object) - 90, 
                         (_shape get "width")
                        ] call Tcore_fnc_sinCosPos;

private _frontPos =        [_posFirst, 
                         (_posSecond), 
                         (getDir _object), 
                         (_shape get "length")
                        ] call Tcore_fnc_sinCosPos;

private _backPos =        [_posFirst, 
                         (_posSecond), 
                         (getDir _object), 
                         -(_shape get "length")
                        ] call Tcore_fnc_sinCosPos;



_objData set ["position", _pos];
_objData set ["top",      _topPos];
_objData set ["right",    _rightPos];
_objData set ["left",     _leftPos];
_objData set ["front",    _frontPos];
_objData set ["back",     _backPos];

_objData