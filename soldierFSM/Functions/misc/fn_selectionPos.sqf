params ["_man", "_selection"];
private _weaponPos = (_man selectionPosition _selection);
private _toWorld   = _man modelToWorld _weaponPos;

_toWorld;