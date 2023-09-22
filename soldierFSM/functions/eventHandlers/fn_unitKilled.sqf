// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

addMissionEventHandler ["EntityKilled", {
    params ["_man", "_killer", "_instigator", "_useEffects"];

    detach _man;

    //Handle fighting positions
    private _fipo = [_man] call SFSM_fnc_getFipo;
    if(!isNil "_fipo")then{
        [_man, _fipo] spawn SFSM_fnc_handleFipoHit;
    };

    // if!([_man] call SFSM_fnc_isRealMan)exitWith{};
    // Alternative to the isRealMan function (I might refactor it later)
    private _group = group _man;
    if !(_man isKindOf "CAManBase")      exitWith{};
    if (isNull _group)                   exitWith{};
    if (side _group isEqualTo sideLogic) exitWith{};
    if (isObjectHidden _man)             exitWith{};

    _man setVariable ['SFSM_killTime', time];
    _man setVariable ['SFSM_killer',  _killer];

    // Set FIPO to FUBAR if possible / needed.
    [_man] call SFSM_fnc_fipoKnockOut;

    // Adjust morale on relevant men.
    [_man, _killer, _instigator] call SFSM_fnc_moraleOnKill;

    private _building = _unitData get "currentBuilding";
    if(_building isNotEqualTo "none")
    then{missionNamespace setVariable [_building, nil, true];};


    private _battleKey = _unitData get "currentBattle";
    if(_battleKey == "none")exitWith{};

    //add the deceased to the battlefield-hashmap.
    private _battleField = SFSM_Battles get _battleKey;
    missionNamespace getVariable (_battleField get "deadMen") pushBack _man;

    [_man] spawn SFSM_fnc_AddWeaponsToBattlefield;
    [_man] spawn SFSM_fnc_pickUpFreshAT;

    //Used for the inventory opened eventhandler
    _man setVariable ["SFSM_side", (side group _man)];

    //log sniper kill
    if(SFSM_Debugger
    &&{(_man getVariable ["SFSM_myAssasin", objNull]) isEqualTo _instigator
    &&{alive _instigator}})
    then{
            [_instigator, _man] spawn SFSM_fnc_handleMarksmanHit;
    };
    
}];