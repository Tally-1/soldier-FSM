//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ['_pos', '_radius'];
private _buildings = nearestObjects [_pos, ["house"], _radius] select {[_x] call SFSM_fnc_houseAvailable};
if(_buildings isEqualTo [])exitWith{};

private _nearest   = ([_buildings, [], {_pos distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;

_nearest;