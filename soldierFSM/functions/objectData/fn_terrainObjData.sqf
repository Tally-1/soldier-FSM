params ["_object"];
private _terrainObjData = createHashmap;
private _typeName       = [_object] call Tcore_fnc_simpleObjectType;
private _3dData         = [_object] call Tcore_fnc_object3DShape;
private _properties     = (createHashMapFromArray namedProperties _object);
private _ownerUnit      = "";

_terrainObjData set ["type", _typeName];
_terrainObjData set ["3dData", _3dData];
_terrainObjData set ["properties", _properties]; 

_terrainObjData