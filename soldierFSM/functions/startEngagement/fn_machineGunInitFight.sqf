// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man"];

private _battleKey = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battlefield = SFSM_Battles get _battleKey;

if(isNil "_battlefield")exitWith{};

if(_man getVariable ["ace_isunconscious", false])exitWith{};
if(_man getVariable ["dam_ignore_injured0",false])exitWith{};

private _side          = side _man;
private _allClusterPos = (_battlefield get "clusterPositions");
private _coverPos      = [_man] call SFSM_fnc_getCoverPos;
private _coverPosFound = ((!isNil "_coverPos") && {typeName _coverPos == "ARRAY"});

"starting suppression" call SFSM_fnc_debugMessage;

[_man, "action", "!!! Suppressing enemy !!!"] call SFSM_fnc_unitData;

//suppress enemy clusters
private _enemyClusterPositions = [_side, _battlefield] call SFSM_fnc_getEnemyPositions;
private _script = [_man, _enemyClusterPositions] spawn SFSM_fnc_supressPositions;
waitUntil {sleep 0.5; scriptDone _script};

if(isNil "_battlefield")exitWith{[_man, "action", "none"] call SFSM_fnc_unitData};

//move to coverposition if possible
if(! _coverPosFound)
then{
        _coverPos      = [_man] call SFSM_fnc_getCoverPos;
        _coverPosFound = ((!isNil "_coverPos") && {typeName _coverPos == "ARRAY"});
    };

// if forced regroup is in play then wait.
// if([_man, "action"] call SFSM_fnc_unitData isNotEqualTo "none")then{
//     private _timer = time + 10;
//     waitUntil {
//         sleep 0.5; 
//         ([_man, "action"] call SFSM_fnc_unitData isEqualTo "none"
//         || time > _timer)
//     };
// };

if(_coverPosFound
&&{_man distance2D _coverPos > 2.5})
then{
        
        [_man, "Suppressing and Moving"] call SFSM_fnc_setAction;
        _script = [_man, _coverPos, 3] spawn SFSM_fnc_forceMove2;
        waitUntil {sleep 1; scriptDone _script};
    };
    
sleep 2;

if ([_man] call SFSM_fnc_abortSpecial)exitWith{
    private _regrouping = [_man] call SFSM_fnc_getAction isEqualTo "Forced regroup";
    if!(_regrouping)then{[_man, "none"] call SFSM_fnc_setAction;};
};

[_man, "action", "Suppressing enemy positions"] call SFSM_fnc_unitData;

if(isNil "_battlefield")exitWith{[_man, "none"] call SFSM_fnc_setAction;};

//now suppress every single enemy individually
private _radius = _battlefield get "radius";
private _allEnemyPos = [_man, (_radius*2)] call Tcore_fnc_nearKnownEnemies;
private _script = [_man, _allEnemyPos] spawn SFSM_fnc_supressPositions;
waitUntil {sleep 0.5; scriptDone _script};

if(isNil "_battlefield")exitWith{[_man, "action", "none"] call SFSM_fnc_unitData};

if(_coverPosFound
&&{_man distance2D _coverPos > 2.5
&&{(!([_man] call SFSM_fnc_isUncon))
}})
then{
        [_man, "action", "Ending suppression"] call SFSM_fnc_unitData;
        _script = [_man, _coverPos, 3] spawn SFSM_fnc_forceMove2;
        waitUntil {sleep 1; scriptDone _script};
    };

"machineGunner ended suppression of enemy" call SFSM_fnc_debugMessage;
[_man, "action", "none"] call SFSM_fnc_unitData;
_man doFollow leader (group _man);

["mg_suppressionEnd", [_man]]   call CBA_fnc_localEvent;

if ([_man] call SFSM_fnc_abortSpecial)exitWith{
    private _regrouping = [_man] call SFSM_fnc_getAction isEqualTo "Forced regroup";
    if!(_regrouping)then{[_man, "none"] call SFSM_fnc_setAction;};
};

[_man] call SFSM_fnc_postCoverActions;
true;