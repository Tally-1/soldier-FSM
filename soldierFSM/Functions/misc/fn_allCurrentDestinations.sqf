// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _destinations = [];

{
    if([_x] call SFSM_fnc_isRealMan)
    then{
          private _destination = [_x, "currentDestination"] call SFSM_fnc_unitData;
          if((!isNil '_destination')
          &&{!(_destination isEqualTo [0,0,0])})
          then{_destinations pushBackUnique _destination;};
    }
    
} forEach (entities "CAManBase");
_destinations;