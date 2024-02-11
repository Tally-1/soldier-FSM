// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

addMissionEventHandler ["EntityCreated", {
    params ["_entity"];
    if([_entity] call Tcore_fnc_nilNull)exitWith{};
    if([_entity] call Tcore_fnc_isPlayer)exitWith{};

    if!(_entity isKindOf "CAManBase")
    exitwith{

        if(_entity isKindOf "man")   exitWith{};//animals are of type "man" but not type "CAManBase".
        if(_entity isKindOf "logic") exitWith{"Logic spawned in" call dbgmsg;};

        if (_entity isKindOf "land" || _entity isKindOf "air") 
        then {
            [_vehicle] call SFSM_fnc_initVehicle;
            [['Vehicle type: "',typeOf _entity,'" spawned in.']] call dbgmsg;

        };
    };
    
    if!([_entity, true] call SFSM_fnc_isRealMan)exitWith{};

    [_entity] call SFSM_fnc_initMan;
    [["Unit ",(typeOf _entity)," spawned in"]] call dbgmsg;
}];

addMissionEventHandler ["GroupCreated", {
    params ["_group"];
    private _client = clientOwner;
    [_group, _client] remoteExecCall ["SFSM_fnc_onGroupCreated", 2];
    SFSM_newGroups pushBackUnique _group;    
}];

addMissionEventHandler ["GroupDeleted", {
    params ["_group"];
    "Group deleted" call dbgmsg;
}];