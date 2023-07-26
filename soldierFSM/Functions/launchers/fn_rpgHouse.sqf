// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_building"];
private _buildingVarName = ["Occupied building ", (name _man), (getPos _building)] joinString "_";
private _buildingPos     = [_building] call SFSM_fnc_buildingCenterPosASL;
private _launchPos       = getPos _man;
private _canSee          = ([_man, "VIEW", _building] checkVisibility [aimPos _man, _buildingPos])>0.8;

if!(_canSee)then{_launchPos = [_man, _building] call SFSM_fnc_firePosLite;};

if(isNil "_launchPos")
exitWith{"could not find a position to launch from" call dbgmsg;};

[_man, "currentDestination", _launchPos] call SFSM_fnc_unitData;
[_man, "action", "CQB: Engaging house with launcher"] call SFSM_fnc_unitData;
[_man, "targetBuilding", _buildingVarName] call SFSM_fnc_unitData;
missionNamespace setVariable [_buildingVarName, _building];


_man setAnimSpeedCoef SFSM_sprintSpeed;

if((_launchPos distance2D _man) > 3)
then{
    private _move = [
            _man,      //unit 
            _launchPos,//position 
            30,        //timeout (optional)
            2,         //minimum distance to position in order to complete move. (optional)
            3          // sleep between each repetition of doMove. (optional)
            ] spawn SFSM_fnc_forceMove2;

    waitUntil{sleep 1.5; scriptDone _move;};
};

_man setAnimSpeedCoef 1;

if(!alive _man)
exitWith{
        "man died before using launcher" call dbgmsg;
        [_man, "targetBuilding", "none"] call SFSM_fnc_unitData;
        missionNamespace setVariable [_buildingVarName, nil];
        [_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;
    };

_canSee = ([_man, "VIEW", _building] checkVisibility [aimPos _man, _buildingPos])>0.8;

if!(_canSee)exitWith{
    [_man, "action", "failed to get LOS on the building"] call SFSM_fnc_unitData;
    sleep 3;
    _man doMove (getPos _man);
    _man doFollow (leader(group _man));
    [_man, "action", "none"] call SFSM_fnc_unitData;
    [_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;
    [_man, "targetBuilding", "none"] call SFSM_fnc_unitData;
    missionNamespace setVariable [_buildingVarName, nil];
    };

["CQB_rpgFire", [_man, _building]] call CBA_fnc_localEvent;

_man doWatch (ASLToAGL _buildingPos);

_man setVariable ["SFSM_missileTarget", _buildingPos];

sleep 1;
private _dir = (_man getDir _building);
_man setDir _dir;
_man doWatch objNull;
private _doFire = [_man, nil, _dir] spawn SFSM_fnc_forceFireLauncher;

waitUntil{scriptDone _doFire;};

_man setVariable ["SFSM_missileTarget", nil];
[_man, "action", "none"] call SFSM_fnc_unitData;
[_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;
[_man, "targetBuilding", "none"] call SFSM_fnc_unitData;
_man doMove (getPos _man);
_man doFollow (leader(group _man));
missionNamespace setVariable [_buildingVarName, nil];