//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Assigns all static weapons in the battlefield to the groups in the battlefield.

// Params: _battlefield(hashmap) - Battlefield object (found in the SFSM_Battles variable)

// Return value: true

// Example: [_battlefield] spawn SFSM_fnc_assignBattlefieldTurrets;

params["_battlefield"];
private _center = _battlefield get "center";
private _radius = _battlefield get "radius";

while {sleep 10; !isNil "_battlefield"} do {

    if(isNil "_battlefield")exitWith{};

    private _groups = missionNamespace getVariable   (_battlefield get "groups");
    private _vehicles = _center nearEntities ["staticWeapon", _radius];

    if((!isNil "_vehicles") && {!isNil "_groups"})then{
        [_vehicles, _groups] spawn SFSM_fnc_manAllTurrets;
    };

    [_battlefield] call SFSM_fnc_leaveBattlefieldTurrets;

    if(isNil "_battlefield")exitWith{};
};

["Ended battlefield turret assignement", 2]call dbgmsg;
true;