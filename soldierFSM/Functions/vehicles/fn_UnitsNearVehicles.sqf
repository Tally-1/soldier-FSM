// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_units","_vehicles", "_maxDistance"];
private _unitsInReach = [];
{
    private _nearestVehicle = [_x, _vehicles] call Tcore_fnc_nearestPos;
    if(typeName _nearestVehicle == "object"
    &&{(_nearestVehicle distance2D _x) < _maxDistance
    &&{alive _x
    &&{(!(_x getVariable ["ace_isunconscious", false]))
    &&{!(_x getVariable ["dam_ignore_injured0",false])
    }}}})
    then{_unitsInReach pushBack _x;};
    
} forEach _units;


_unitsInReach;