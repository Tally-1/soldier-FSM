params["_sector3D"];

//params will destruct an array similar to the way JS does it
_sector3D params ["_lines", "_txtPos", "_text", "_color"];

{drawLine3D _x;} forEach _lines;

if(_text isNotEqualTo "")then{
    [
        _txtPos,
        _color,
        _text,
        ""
    ] call FIPO_fnc_drawObjectMarker;
};

true;