// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3


params ["_man", "_launchPos", "_shooter"];
if([_man] call Tcore_fnc_isPlayer)exitWith{};

private _timer     = time + 5;
private _canFlinch = [_man] call SFSM_fnc_canFlinch;

if(_canFlinch)    
then{
        [_man, true, _shooter] call SFSM_fnc_flinch;
        waitUntil{sleep 0.25; [_man, _timer] call SFSM_fnc_manAvailable};
        [_man] call SFSM_fnc_normalizeStance;
    };

[_man, _launchPos] call SFSM_fnc_eventTriggeredCover;