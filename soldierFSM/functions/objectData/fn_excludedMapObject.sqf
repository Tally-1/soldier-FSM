// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_object"];
private _typeName    = [_object] call Tcore_fnc_simpleObjectType;
private _objectShape = [_object] call Tcore_fnc_object3DShape;
private _height      = _objectShape get "height";
private _excluded = false;

if (_height < 0.4)  exitwith{true};
if (_typeName == "")exitWith{true};

{
    
    if(_x in _typeName) 
    exitWith {_excluded = true};

} forEach SFSM_excludedMapObjs;


_excluded;