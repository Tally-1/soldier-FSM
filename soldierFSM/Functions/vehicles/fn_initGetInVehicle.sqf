// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_vehicle", "_man"];

private _actionText = ["Getting vehicle as ", _role, "!"] joinString "";
[_man, "action", _actionText]call SFSM_fnc_unitData;

private _targetedBy = _vehicle getVariable "targetedBy";

if(isNil "_targetedBy")
then{
    _vehicle setVariable ["targetedBy", []];
};
(_vehicle getVariable "targetedBy")pushBackUnique _man;

true;