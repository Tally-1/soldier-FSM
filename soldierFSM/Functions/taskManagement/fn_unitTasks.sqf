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
        private _data = _x getVariable "SFSM_UnitData";
                
        if(isNil "_data")
        then{[_x] call SFSM_fnc_InitMan}
        else{[_x] call SFSM_fnc_HandleSuppression;};

        if!(SFSM_globalUD)then{
        _x setVariable["SFSM_UnitData", _data, true];
    };
        
        
};
} forEach allUnits;