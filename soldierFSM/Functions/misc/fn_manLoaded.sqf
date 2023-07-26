// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man"];
if(isNil "_man")exitWith{false};
if(isNull _man)exitWith{false};

private _unitData = _man getVariable "SFSM_UnitData";
if(isNil "_unitData")exitWith{false};

true;