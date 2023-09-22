// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man"];
private _handler =
_man addEventHandler ["FiredMan", {
    params ["_man", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
    if(_weapon isEqualTo secondaryWeapon _man)
    then{
        [_man, _projectile] spawn {
            params["_man", "_missile"];
            private _targetPos = _man getVariable "SFSM_missileTarget";
            private _velocityMS = velocityModelSpace _missile;

            //Repeat it just to make sure it actually sticks.
            for "_i" from 0 to 2 do {
            sleep 0.1;
            if(!alive _missile)exitWith{};

            [_missile, _targetPos] call SFSM_fnc_setDirAndPitchToPos;
            _missile setVelocityModelSpace _velocityMS;

            
        };
        
    };


}}];

_handler;