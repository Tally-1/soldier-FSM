// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _actionTxt = "firing launcher!";
params[
    "_man", 
    "_actionTxt", 
    "_wantedDir"
];

[_man, "action", _actionTxt] call SFSM_fnc_unitData;

private _handler  = [_man] call SFSM_fnc_launcherHandler;
private _launcher = secondaryWeapon _man;
private _mode     = (getArray (configFile >> "CfgWeapons" >> _launcher >> "modes"))#0;
private _fired    = (_man getVariable ["SFSM_launched", false]);
private _timer    = time +5;

_man playMoveNow "AmovPercMstpSrasWrflDnon_AmovPercMstpSrasWlnrDnon_end";
_man selectWeapon _launcher;

waitUntil {

    if(!isNil "_wantedDir"
    &&{(round _wantedDir) != (round(getDir _man))
    &&{(_timer -  time)>= 1}})
    then{_man setDir _wantedDir};

    if(isNil "_mode")then{_mode = "this"};

    _man forceWeaponFire [_launcher, _mode];
    _fired = (_man getVariable ["SFSM_launched", false]);
    ((time > _timer) || _fired);
    };

sleep 1;

if!(_fired)then{_man removeEventHandler ["FiredMan", _handler];};
_man setVariable ["SFSM_launched", nil];

[_man, "action", "none"] call SFSM_fnc_unitData;