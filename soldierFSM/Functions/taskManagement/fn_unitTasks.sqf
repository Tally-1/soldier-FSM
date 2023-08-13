// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

{
    if([_x] call SFSM_fnc_isRealMan)
    then{
            [_x] call SFSM_fnc_HandleSuppression;
            // [_x] call SFSM_fnc_normalizeMorale;
            [_x] call SFSM_fnc_updateMorale;
};
} forEach allUnits;