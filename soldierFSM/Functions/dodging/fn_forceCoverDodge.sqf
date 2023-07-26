// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3


params ["_man", "_endPos"];
private _dodgeFromPos   = _endPos;
private _enemyPositions = [_man, 500, "positions"] call Tcore_fnc_nearKnownEnemies;

if(count _enemyPositions > 0)
then{
        private _newPos = [_man, _enemyPositions] call Tcore_fnc_nearestPos;
        if(typeName _newPos == "SCALAR")exitWith{}; //the nearestPos function returns a number when nothing is found
        _dodgeFromPos = _newPos;
    };


[_man, _dodgeFromPos, false] spawn SFSM_fnc_Dodge;

true;