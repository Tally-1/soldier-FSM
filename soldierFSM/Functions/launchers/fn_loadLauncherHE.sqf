params[
   ["_man", nil, [objNull]]
];
private _loadOut = getUnitLoadout _man;
_loadOut params[
   ["_weapon",     nil, [[]]],
   ["_launcher",   nil, [[]]],
   ["_handgun",    nil, [[]]],
   ["_uniform",    nil, [[]]],
   ["_vest",       nil, [[]]],
   ["_backpack",   nil, [[]]],
   ["_headgear",   nil, [""]],
   ["_facewear",   nil, [""]],
   ["_binoculars", nil, [[]]],
   ["_items",      nil, [[]]]
];

_launcher params[
   ["_launcherType", nil, [""]],
   ["_lnchrMuzzle",  nil, [""]],
   ["_lnchrLight",   nil, [""]],
   ["_lnchrOptic",   nil, [""]],
   ["_lnchrMag",     nil, [[]]],
   ["_lnchrMag2",    nil, [[]]],
   ["_lnchrBipod",   nil, [""]]
];

if(isNil "_lnchrMag")exitWith{};

private _currentMissile = _lnchrMag#0;
private _unitMags       = magazines _man;
private _usable         = compatibleMagazines _launcherType;
private _missiles       = _unitMags select {_x in _usable;};
private _types          = [];

{_types pushBackUnique _x;} forEach _missiles;

if(count _types    < 2)exitWith{}; 

if(isNil "_currentMissile")then{
   _currentMissile = "";
   _lnchrMag = ["", 1];
};

_missiles = 
[
   _missiles, 
   [], 
   {[_x] call SFSM_fnc_getMagSplashRange;}, 
   "DESCEND"

] call BIS_fnc_sortBy;

private _HE_Missile = _missiles#0;
if(_currentMissile isEqualTo _HE_Missile)exitWith{};

private _currentSplash = [_currentMissile] call SFSM_fnc_getMagSplashRange;
private _newSplash     = [_HE_Missile] call SFSM_fnc_getMagSplashRange;
private _noIncrease    = _currentSplash >= _newSplash;
if(_noIncrease)exitWith{};

private _newLnchrMag = [_lnchrMag, 0, _HE_Missile]  call SFSM_fnc_replaceInArr;
private _newLauncher = [_launcher, 4, _newLnchrMag] call SFSM_fnc_replaceInArr;
private _newLoadOut  = [_loadOut,  1, _newLauncher] call SFSM_fnc_replaceInArr;
private _reloadAnim  = getText (configfile >> "CfgWeapons" >> _launcherType >> "reloadAction");
private _animVar     = ([_man, _reloadAnim] call SFSM_fnc_animThenExec)#0;

_man setUnitLoadout _newLoadOut;
_man removeMagazine _HE_Missile;
_man addMagazine _currentMissile;

[_man, "Loading HE missile!"] spawn SFSM_fnc_flashAction;

waitUntil { sleep 0.5; _man getVariable _animVar;};
_man setVariable [_animVar, nil];


[_man, "HE missile loaded!"] spawn SFSM_fnc_flashAction;

true;