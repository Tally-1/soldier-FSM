// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_projectile", "_launchPos", "_Shooter"];

_projectile setVariable ["launchPos", _launchPos];

_projectile addEventHandler ["Deflected", {
    params ["_projectile", "_pos", "_velocity", "_hitObject"];
    private _launchPos = _projectile getVariable "launchPos";
    
    _projectile removeAllEventHandlers "Deflected";
    _projectile removeAllEventHandlers "Deleted";

    [_launchPos, _pos] call SFSM_fnc_handleBulletImpact;
}];

_projectile addEventHandler ["Deleted", {
    params ["_entity"];
    private _launchPos = _entity getVariable "launchPos";
    private _pos = getPosASLVisual _entity;
    
    _projectile removeAllEventHandlers "Deflected";
    _projectile removeAllEventHandlers "Deleted";

    [_launchPos, _pos] call SFSM_fnc_handleBulletImpact;
}];