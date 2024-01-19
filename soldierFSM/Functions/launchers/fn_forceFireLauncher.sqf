// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params[
    ["_man",       nil, [objNull]]
];
private _launcher     = secondaryWeapon _man;
private _launcherAnim = "AmovPercMstpSrasWrflDnon_AmovPercMstpSrasWlnrDnon_end";
private _mode         = (getArray (configFile >> "CfgWeapons" >> _launcher >> "modes"))#0;
private _fired        = (_man getVariable ["SFSM_launched", false]);
private _timer        = time +5;

if(isNil "_mode")then{_mode = "this"};

_man playMoveNow _launcherAnim;
_man selectWeapon _launcher;

waitUntil {
    _man selectWeapon _launcher;
    _man forceWeaponFire [_launcher, _mode];
    _fired = (_man getVariable ["SFSM_launched", false]);
    ((time > _timer) || _fired);
};

sleep 0.1;

true;