//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params['_pos'];
private _available = true;
_pos = _pos vectorAdd [0, 0, 0.7];
private _unitsPresent = (_pos nearEntities ["CAManBase", 2]) select {[_x] call SFSM_fnc_isRealMan};
private _destinations = [] call SFSM_fnc_allCurrentDestinations;
private _nearest = [0,0,0];

if(count _destinations > 0)
then{_nearest = ([_destinations, [], {_pos distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;};

if(_nearest distance _pos < 2)
then{_available = false;};


if!(_unitsPresent isEqualTo [])
then{_available = false;};

_available;