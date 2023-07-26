// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

//checks the height of an object in order to determine which stance a man should take to get proper cover behind said object.
//returns 0-2. 0 = stand. 1 = crouch. 2 = prone.
params["_object"];
private _objData = [_object] call Tcore_fnc_object3DShape;
private _height  = _objData get "height";
private _stance  = 0;

if(_height < 1.6)then{_stance  = 1};
if(_height < 0.9)then{_stance  = 2};
_stance