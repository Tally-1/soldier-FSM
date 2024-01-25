params [
	["_object",    nil, [objNull]],
	["_selection", nil,      [""]]
];
private _selectionPos = _object selectionPosition _selection;
private _toWorld      = _object modelToWorld _selectionPos;

_toWorld;