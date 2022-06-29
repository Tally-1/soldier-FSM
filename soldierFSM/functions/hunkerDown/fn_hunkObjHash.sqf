params["_object", "_battlefield"];
Private _mapObjects    = missionNamespace getVariable (_battlefield get "mapObjects");
Private _hunkerObjData = _mapObjects get "hunkerObjData";
private _pos = ASLToAGL (getPosASL _object);
private _key = str _pos;
private _data = _hunkerObjData get _key;

_data