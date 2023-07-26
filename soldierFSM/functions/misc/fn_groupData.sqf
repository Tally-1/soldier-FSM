// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

/*See unitData for comments */
params ["_group", "_item", "_value"];

private _groupData = (_group getVariable "SFSM_groupData");

if(isNil "_groupData")
exitWith{
        if(SFSM_Debugger)then{diag_log "groupData is nil"};
        // [_group] call SFSM_fnc_initGroup;
        // _this call SFSM_fnc_groupData;
        nil;
        };

private _returnVal = _groupData get _item;

if(isNil "_value")exitwith{_returnVal};

_groupData set [_item, _value];
_group setVariable["SFSM_groupData", _groupData, true];

_value;