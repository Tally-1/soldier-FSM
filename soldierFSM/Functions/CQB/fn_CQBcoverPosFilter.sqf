//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _startPos = [(AGLToASL _x), 1] call Tcore_fnc_addZ;
private _endPos = _startPos vectorAdd [0, 0, 10];
private _indoors = (count (lineIntersectsWith [_startPos, _endPos]) > 0);
(_indoors
&&{[_x] call SFSM_fnc_CQBposAvailable})