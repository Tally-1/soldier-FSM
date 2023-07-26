//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_positions"];
private _excluded = [];

{
    private _nearest = [_x, _positions] call Tcore_fnc_nearestPos;
    if(_nearest distance2D _x < 1.2
    &&{!(_nearest isEqualTo _x)})
    then{_excluded pushBackUnique _x};
} forEach _positions;

systemChat (["posEqual =", (_excluded isEqualTo _positions)]joinString"");

_excluded;