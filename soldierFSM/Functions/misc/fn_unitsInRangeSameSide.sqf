// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_unitArr", "_maxDistance"];
private _valids = _unitArr select {
    (_x distance2D _man < _maxDistance
    &&{(side _man)==(side _x)})
};
_valids;