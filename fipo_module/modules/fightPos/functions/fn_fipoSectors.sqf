params["_fipo"];

([_fipo] call FIPO_fnc_fipoSectorsAdjustedWidth) params
["_widthR", "_widthC", "_widthL"];

private _offset       = 1;

private _distR        = _fipo getVariable "rightFlank";
private _distC        = _fipo getVariable "fireSectorDistance";
private _distL        = _fipo getVariable "leftFlank";

private _correctionR  = (_widthR/2);
private _correctionL  = (_widthL/2);

private _angleR       = 0-(180+_correctionR);
private _angleL       = 180+_correctionL;

private _rightSector = [
    _fipo,
    _angleR,
    _distR,
    _widthR,
    _offset
] call FIPO_fnc_getObjectSector;

private _centerSector = [
    _fipo,
    0,
    _distC,
    _widthC,
    _offset
] call FIPO_fnc_getObjectSector;

private _leftSector = [
    _fipo,
    _angleL,
    _distL,
    _widthL,
    _offset
] call FIPO_fnc_getObjectSector;

[_rightSector, _centerSector, _leftSector];