params ["_marksman"];
_marksman addEventHandler ["Fired", {
    params ["_marksman", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    
    private _wrongTarget = [_marksman] call SFSM_fnc_correctTarget;
    if(_wrongTarget)exitWith{
        _marksman setVariable ["SFSM_marksmanAction", "Adjusting to correct target", true];
    };

    if!(SFSM_debugger)exitwith{};
    
    private _color = [(side _marksman)] call SFSM_fnc_sideColor;

    _projectile setVariable ["SFSM_IconColor", _color];
    _projectile setVariable ["SFSM_MrkmnSht", true];

    if(hasInterface)
    then{SFSM_bullets pushBack _projectile};
    
    // [_projectile]spawn SFSM_fnc_bulletTracker;
    _projectile setVariable ["SFSM_track",[ASLToAGL (eyePos _marksman)]];
}];
