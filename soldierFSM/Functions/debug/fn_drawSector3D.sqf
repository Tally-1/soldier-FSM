params["_sector3D"];
private _poss      = _sector3D#0;
private _lines     = _sector3D#1;
private _text      = _sector3D#3;

{drawLine3D _x;} forEach _lines;

if(_text isNotEqualTo "")then{
    private _txtPos = _sector3D#2;
    private _color  = _sector3D#4;
    [
        _txtPos,
        _color,
        _text,
        ""
    ] call SFSM_fnc_drawObjectMarker;
};

{[_x, _color] call SFSM_fnc_drawObjectMarker;} forEach _poss;
