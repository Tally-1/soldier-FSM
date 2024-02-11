// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man"];

_man addEventHandler ["Fired", {
    params [
                "_man", 
                "_weapon", 
                "_muzzle", 
                "_mode", 
                "_ammo", 
                "_magazine", 
                "_projectile", 
                "_gunner"
            ];
    
    
    [_man]                              call SFSM_fnc_triggerBattleOnShot;
    [_man, _muzzle, _weapon]            call SFSM_fnc_multiplyReactionFire;
    [_man]                              call SFSM_fnc_soundReaction;
    [_man, "last_bullet_fired", time]   call SFSM_fnc_unitData;
    [_projectile, _ammo, _man, _gunner] call SFSM_fnc_projectileEH;
    [_man]                              call SFSM_fnc_rearm;
    
    SFSM_lastShotFired = time;
    _man setVariable["SFSM_prevTarget", (getAttackTarget _man)];

    if(secondaryWeapon _man isNotEqualTo "")then{
        [_man] call SFSM_fnc_forcedCqbRpg;
    };

    if(captive _man)then{
        _man setCaptive false;
        _man setVariable ["SFSM_captive", false];
        _man enableAI "all";
    };
    
    true;
}];