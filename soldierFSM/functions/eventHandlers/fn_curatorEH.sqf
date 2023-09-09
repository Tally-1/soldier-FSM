
// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

_this addEventHandler ["CuratorObjectSelectionChanged", 
{
    params ["_curator", "_entity"];
    if!(SFSM_Debugger)exitWith{};

    private _selectedObjects = curatorSelected#0;

    if([_entity, true, true, true, true] call SFSM_fnc_canRun)then{
        [_entity] call SFSM_fnc_manInfo;
        
        private _men = _selectedObjects select{[_x, true, true, true, true] call SFSM_fnc_canRun;};
        if(_men isEqualTo [])exitWith{SFSM_AimingMen = []};
        
        SFSM_AimingMen      = _men;
        SFSM_currentCurObj = _entity;
    };

    if(count _selectedObjects isEqualTo 1
    &&{[_entity, true] call SFSM_fnc_inFipo})then{
        [_entity] spawn SFSM_fnc_curatorFipoFlanks;
    };
}];

_this addEventHandler ["CuratorWaypointPlaced", {
    params ["_curator", "_group", "_waypointID"];
    if!(SFSM_ExcludeZcommand)exitWith{};
    _this call SFSM_fnc_zWPplaced;
}];

_this addEventHandler ["CuratorWaypointDeleted", {
    params ["_curator", "_waypoint"];
    if!(SFSM_ExcludeZcommand)exitWith{};
    _this call SFSM_fnc_zWPdeleted;
}];

_this addEventHandler ["CuratorObjectDeleted", {
    params ["_curator", "_man"];
    private _unitData = _man getVariable "SFSM_UnitData";
    if(isNil "_unitData")          exitWith{};
    if!(_man isKindOf "caManBase") exitWith{};
    if!(alive _man)                exitWith{};

    "Unit was deleted by curator" call dbgmsg;

    private _currentBattle = [_man] call SFSM_fnc_getBattleField;
    if(isNil "_currentBattle")exitWith{};
    [] call SFSM_fnc_deleteWarning;
}];