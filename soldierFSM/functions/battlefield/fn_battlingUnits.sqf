//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3


params["_battleField"];
private _pos    = (_battleField get "center");
private _radius = (_battleField get "radius");
private _units  = missionNamespace getVariable (_battleField get "units");
private _unitsFighting = [];

{
    private _target = getAttackTarget _x;
    if(!isNull _target
    &&{(_target distance2D _pos) < _radius})
    then{
            _unitsFighting pushBack _x;
        };
} forEach _units;

_unitsFighting