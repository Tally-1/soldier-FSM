params["_building"];
private _shape  = [_building] call Tcore_fnc_object3DShape;
private _height = _shape get "height";

private _base   = AGLToASL getpos _building;
private _center = [_base#0, _base#1, (_base#2)+(_height/2)];

_center;