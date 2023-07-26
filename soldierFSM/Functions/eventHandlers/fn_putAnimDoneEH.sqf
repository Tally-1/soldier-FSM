// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man"];
_man addEventHandler ["AnimDone", {
    params ["_unit", "_anim"];
    if("AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon" == _anim)
    then{
        // [_unit, "action", "none"] call SFSM_fnc_unitData;
        _unit setVariable ["SFSM_animDone", true];
        _unit removeEventHandler [_thisEvent, _thisEventHandler];
    };
}];