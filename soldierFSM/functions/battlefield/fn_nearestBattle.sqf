//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: finds the nearest battle to a given position

// Params: _position: [number, number, number]

// Return value: _nearestBattle (hashmap)

// Example: [(getPos player)] call SFSM_fnc_nearestBattle;

params["_position"];
if(count SFSM_battles < 1)exitWith{objNull};

private _battlePositions = [];
{
    private _battlePosition = _y get "center";
    _battlePositions pushBackUnique _battlePosition;
} forEach SFSM_battles;

private _nearestPos = [_position, _battlePositions] call Tcore_fnc_nearestPos;


_nearestBattle = SFSM_battles get (str _nearestPos);

if(isNil "_nearestBattle")exitWith{objNull};

_nearestBattle