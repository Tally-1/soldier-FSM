private _color   = [1,0,0,1];
private _text    = "";
params["_sector", "_color", "_text"];
_sector params ["_pos", "_dir", "_width", "_distance"];

private _edgePositions  = [_sector] call FIPO_fnc_sectorEdgePositions;
private _lines          = [_edgePositions, _color] call FIPO_fnc_sector3DLines;
private _dist           = round(_distance * 1.1);
private _txtPos         = (_pos getPos [_dist, _dir])apply{round _x};

[_lines, _txtPos, _text, _color];