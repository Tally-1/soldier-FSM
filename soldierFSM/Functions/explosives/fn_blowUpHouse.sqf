// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Sends a AI man to place an explosive inside a building

// Params: [_man:object, _building:object]

// Return value: none

// Example: [_mySoldado, _myBuilding] spawn SFSM_fnc_blowUpHouse;

params[
        "_man", 
        "_building"
    ];

//init function variables
private _startPos = getPos _man;
private _startDistance = (_building distance2D _startPos);
private _bPos = (getPos _building);
private _escapeDir = _building getDir _startPos;
private _escapePos = [_bPos#0, _bPos#1, _escapeDir, 100] call Tcore_fnc_sinCosPos;
private _timer = time +30;
private _buildingVarName = ["Occupied building ", (name _man), (getPos _building)] joinString "_";
private _path = [_building, true, _startPos] call SFSM_fnc_buildingPath;
private _startSpeedMode = speedMode _man;
[_man, _building, _buildingVarName] call SFSM_fnc_initHouseDemolition;
[_man, "action", "CQB: moving to place explosives"] call SFSM_fnc_unitData;

//move into house.
{
    

    // private _moveIn = 
    [
        _man, //unit 
        _x,   //position 
        4,    //timeout (optional)
        3,    //minimum distance to position in order to complete move. (optional)
        2     // sleep between each repetition of doMove. (optional)
        ] call SFSM_fnc_forceMove2;

    // waitUntil{sleep 1; scriptDone _moveIn;};
    
    private _distance = (_man distance2D _building);
    private _currentBuilding = [_man]call SFSM_fnc_currentBuilding;
    private _arrived = ((!isNil "_currentBuilding") &&{_currentBuilding == _building});
    
    //conditions for ending "move-in loop"
    if((_arrived)
    || (!alive _man)
    || (time > _timer
    || ((_distance > _startDistance)
    && {_distance > SFSM_dodgeDistance})))
    exitWith{};
    
} forEach _path;

//check status 
private _currentBuilding = [_man]call SFSM_fnc_currentBuilding;
private _arrived = ((!isNil "_currentBuilding") && {_currentBuilding == _building});
private _success = (alive _man && {_arrived});

//if man is dead or not inside the house.
if!(_success)
exitWith{
          [_man, "action", "Demolition failed!"] call SFSM_fnc_unitData;
          sleep 2;
          [_man, _buildingVarname] call SFSM_fnc_endCQBclearing;
          _building setVariable ["SFSM_explosiveRigged", false];
    };


//place explosive
// private _placeExplosive = 
[_man, "Placing explosives"] call SFSM_fnc_placeExplosive;
// waitUntil{(scriptDone _placeExplosive || time > _timer)};

["CQB_explosivePlaced", [_man, _building]] call CBA_fnc_localEvent;

//Get out!
[_man, "action", "explosives placed. RUN!"] call SFSM_fnc_unitData;
// private _script = 
[_man, _escapePos, 30, 60] call SFSM_fnc_clearCQBPos;
// waitUntil{
//     sleep 1; 
//     (scriptDone _script);
//     };



//if man is dead
if(!alive _man)exitWith{
    "man died before detonating explosives" call dbgmsg;
    [_man, _buildingVarname] call SFSM_fnc_endCQBclearing;
    _building setVariable ["SFSM_explosiveRigged", false];
};

//blow it up
[_man, "action", "Detonating explosives"] call SFSM_fnc_unitData;
["CQB_exploded", [_man, _building]] call CBA_fnc_localEvent;
sleep 1;
_man action ["TouchOff", _man];
sleep 1;
[_man, "action", "none"] call SFSM_fnc_unitData;
[_man, _startSpeedMode] call SFSM_fnc_endCQBclearing;
_building setVariable ["SFSM_explosiveRigged", false];

true;