// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_projectile", "_launchPos", "_shooter", "_ammoType"];

_projectile setVariable ["launchPos", _launchPos];
_projectile setVariable ["shooter", _shooter];
_projectile setVariable ["ammoType", _ammoType];

_projectile addEventHandler ["Explode", {
    params ["_projectile", "_pos", "_velocity"];

    _projectile removeEventHandler [_thisEvent, _thisEventHandler];
    private _launchPos = _projectile getVariable "launchPos";
    private _shooter = _projectile getVariable "shooter";
    private _ammoType = _projectile getVariable "ammoType";
    
    [_launchPos, _pos, _shooter, _ammoType] spawn SFSM_fnc_handleExplosion;
    
}];