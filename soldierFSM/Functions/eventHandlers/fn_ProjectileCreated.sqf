// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

addMissionEventHandler ["ProjectileCreated", {
    params ["_projectile"];
    
    private _ammoType = typeOf _projectile;
    private _parents  = getShotParents _projectile;
    private _unknownParents = (count _parents < 2)
                            ||(isNull (_parents#0) 
                            && {isNull (_parents#1)});
    
    if(_unknownParents)exitWith{
    [    
        _projectile,
        _ammoType,
        objNull,
        objNull

    ] call SFSM_fnc_projectileEH;

    };

}];