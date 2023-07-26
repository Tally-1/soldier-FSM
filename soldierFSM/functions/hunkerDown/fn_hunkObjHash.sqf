// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_object", "_battlefield"];
Private _mapObjects    = missionNamespace getVariable (_battlefield get "mapObjects");
Private _hunkerObjData = _mapObjects get "hunkerObjData";
private _pos = ASLToAGL (getPosASL _object);
private _key = str _pos;
private _data = _hunkerObjData get _key;

_data