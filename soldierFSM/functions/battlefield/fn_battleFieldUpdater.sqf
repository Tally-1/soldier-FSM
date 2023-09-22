//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: This script is the main loop of the battlefield. It is called by the SFSM_fnc_battlefieldPostInit and runs until the battle is over.

// Params: [_battleField:hashmap]

// Return value: true

// Example: [_battleField] spawn SFSM_fnc_battleFieldUpdater;

params ['_battleField'];
private _looping = _battleField get "loop activated";
if(!isNil "_looping")exitWith{};

_battleField set ["loop activated", true];

[["Battlefield loop initializing"], 2] call dbgmsg;
while {!isNil "_battleField"} 
do     {
        _battlefield set ["currentAction",    "none"];
        private _ended = [_battleField] call SFSM_fnc_updateBattlefield;
        if(isNil "_ended") exitWith{};
        if(_ended)         exitWith{};
        
        // Calling the function is better for performance, but may destroy the loop in case of a unhandled exception.
        if(SFSM_spawnBffActions isEqualTo false)then{
            [_battleField] call  SFSM_fnc_battlefieldActions;
        
        }else{
        private _script = [_battleField] spawn  SFSM_fnc_battlefieldActions;
        waitUntil {
                sleep 1;
                private _finito = scriptDone _script;
                if(isNil "_finito")exitWith{true;};
                _finito; 
            };

        sleep 1;
        true;
    }};

true;