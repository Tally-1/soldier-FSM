//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_positions", "_minRadius"];
private _center = [_positions] call Tcore_fnc_avgPos;
private _radius = 0;

if!(_center isEqualTo [])
then{
        _radius = [_center, _positions] call Tcore_fnc_clusterSize;
        _radius = _radius*1.2;
        if(_radius < _minRadius)then{_radius = _minRadius};
    
    };

[_center, _radius];