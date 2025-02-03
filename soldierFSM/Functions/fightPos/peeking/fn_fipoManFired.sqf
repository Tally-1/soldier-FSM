params ["_man"];
if!(SFSM_debugger)exitwith{};

_man addEventHandler ["Fired", {
    if(!hasInterface)exitWith{};

    params ["_man", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    private _color = [(side _man)] call SFSM_fnc_sideColor;
    _projectile setVariable ["SFSM_IconColor", _color];
    SFSM_bullets  pushBack _projectile;
}];
