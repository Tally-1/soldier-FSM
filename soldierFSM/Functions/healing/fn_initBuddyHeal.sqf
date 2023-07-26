// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: initializes SFSM medical actions.

// Return value: none

// Example: [
    // _healer,
    // _wounded,
    // _incapacitated
    // ] call SFSM_fnc_buddyHealInit;

params[
    "_healer",         //object(man)
    "_wounded",       //array [object(man)]
    "_incapacitated" //array [object(man)]
];
_incapacitated = _incapacitated select {[_healer, _x] call SFSM_fnc_canBuddyHeal;};
_wounded       = _wounded       select {[_healer, _x] call SFSM_fnc_canBuddyHeal;};

if(count _incapacitated > 0)exitWith{
    private _toBeRevived = [_healer, _incapacitated] call SFSM_fnc_getNearestOrPlayer;
    // private _reviver     = [_allHealers, _toBeRevived] call SFSM_fnc_nearestHealer;

    [_healer, _toBeRevived] spawn SFSM_fnc_buddyRevive;
    true;
};

if(count _wounded > 0)exitWith{
    private _toBeHealed = [_healer, _wounded] call SFSM_fnc_getNearestOrPlayer;
    [_healer, _toBeHealed] spawn SFSM_fnc_buddyHeal;
    true;
};

false;