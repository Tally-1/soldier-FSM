/*
Sets a text as texture on a object.
Example:
[
    _myScreen,     // object 
    "My text",     // text
    0,             // selection (0 is default), chose "clan" to set an armpatch on infantry, or text on vehicles
    0.4,           // textSize (0-1)
    "#6fff00",     // text-color
    "#ff000000"    // background-color
] call Tcore_fnc_setTextTexture;

*/

private _backgroundColor = "#0b0b55d6";
private _textColor       = "#11ff00";
private _font            = "RobotoCondensedLight";
private _fontSize        = 0.1;
private _xPos            = 0;
private _yPos            = 0;
private _selection       = 0;

params [
    "_object", 
    "_text", 
    "_selection",
    "_fontSize",
    "_textColor", 
    "_backgroundColor",
    "_font"    
    ];

private _rgbPx      = "#(rgb,128,128,3)text";

private _texture    = [_rgbPx, '(', _xPos,',', _yPos,',"',_font,'",', _fontSize,',"', _backgroundColor,'","', _textColor,'","', _text,'")']joinString'';

_object setObjectTexture [_selection, _texture];

_texture;