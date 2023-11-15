params ["_man", "_selection"];
private _selectionPos = (_man selectionPosition _selection);
private _toWorld   = _man modelToWorld _selectionPos;

_toWorld;