// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_array"];
if(isNil "_array")              exitWith{false;};
if!(typeName _array == "ARRAY") exitWith{false;};

private _2Dpos = _array isEqualTypeArray [0,0];
private _3Dpos = _array isEqualTypeArray [0,0,0];

private _validPosition = (_2Dpos || _3Dpos);

_validPosition;