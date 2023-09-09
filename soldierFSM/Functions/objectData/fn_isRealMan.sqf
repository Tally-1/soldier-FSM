// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _ignoreUnitData = false;
params[
    "_man",            // Object - The unit to check
    "_ignoreUnitData"  // Bool   - Ignore the unitData check
];

private _isRealMan = true;

isNil{//Forced unscheduled execution

    if!(typeName _man isEqualTo "OBJECT")   exitWith {_isRealMan = false};
    if!(alive _man)                         exitWith {_isRealMan = false};
    if!(_man isKindOf "CAManBase")          exitWith {_isRealMan = false};

    private _group = group _man;
    if(isNull _group)                       exitWith {_isRealMan = false};
    if(side _group == sideLogic)            exitWith {_isRealMan = false};
    if([_man] call SFSM_fnc_isDeactivated)  exitWith {_isRealMan = false};
    if(isObjectHidden _man)                 exitWith {_isRealMan = false};

    if(_ignoreUnitData)                     exitWith{_isRealMan = true;};

    private _action = [_man, "action"] call SFSM_fnc_unitData;
    if(isNil "_action")   exitWith {_isRealMan = false};
};


_isRealMan;