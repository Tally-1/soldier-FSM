// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_object"];
private _terrainObjData = createHashmap;

isNil{//Forced unscheduled execution
private _typeName       = [_object] call Tcore_fnc_simpleObjectType;
private _3dData         = [_object] call Tcore_fnc_object3DShape;
private _properties     = (createHashMapFromArray namedProperties _object);
private _ownerUnit      = "";

_terrainObjData set ["type", _typeName];
_terrainObjData set ["3dData", _3dData];
_terrainObjData set ["properties", _properties]; 
};

_terrainObjData;