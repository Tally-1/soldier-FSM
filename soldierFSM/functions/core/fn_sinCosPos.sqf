params ["_OrigX", "_OrigY", "_Dir", "_Distance"];
Private _NewX = ((sin _Dir) * _Distance) + _OrigX;
Private _Newy = ((cos _Dir) * _Distance) + _OrigY;

Private _Pos = [_NewX,_NewY, 0];

_Pos