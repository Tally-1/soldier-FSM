// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_OrigX", "_OrigY", "_Dir", "_Distance"];
Private _NewX = ((sin _Dir) * _Distance) + _OrigX;
Private _Newy = ((cos _Dir) * _Distance) + _OrigY;

Private _Pos = [_NewX,_NewY, 0];

_Pos