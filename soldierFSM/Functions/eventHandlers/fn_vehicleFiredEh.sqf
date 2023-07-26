// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_vehicle"];
_vehicle addEventHandler ["Fired", {
    params [
                "_unit", 
                "_weapon", 
                "_muzzle", 
                "_mode", 
                "_ammo", 
                "_magazine", 
                "_projectile", 
                "_gunner"
            ];
    
    [_unit]                              call SFSM_fnc_soundReaction;
    [_projectile, _ammo, _unit, _gunner] call SFSM_fnc_projectileEH;
    

    


    SFSM_lastShotFired = time; 
    true;
}];