params["_hObject", "_hunkerObjData"];
private _pos       = (ASLToAGL (getPosASLVisual _hObject));
private _objKey    = str _pos;
private _available = ((_hunkerObjData get _objKey) get "owner") == "none";
_available