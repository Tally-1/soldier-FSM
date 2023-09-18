params["_module", "_man"];


if(_module getVariable "excluded_sfsm")exitWith{
    _man setVariable ["SFSM_Excluded", true, true];
};

([_module] call TMOD_fnc_getModuleTraits)
params[
    "_aimingAccuracy", 
    "_aimingSpeed", 
    "_aimingShake", 
    "_spotDistance", 
    "_spotTime", 
    "_reloadSpeed",
    "_courage"
];

private _isLeader    = leader group _man isEqualTo _man;
if(_isLeader)then{
    private _commandSkill = _module getVariable "command";
    _man setSkill ["commanding", _commandSkill];
};

_man setSkill ["aimingAccuracy", _aimingAccuracy];
_man setSkill ["aimingSpeed",    _aimingSpeed];
_man setSkill ["aimingShake",    _aimingShake];
_man setSkill ["spotDistance",   _spotDistance];
_man setSkill ["spotTime",       _spotTime];
_man setSkill ["reloadSpeed",    _reloadSpeed];
_man setSkill ["courage",        _courage];

if(_module getVariable "aimingErrorDisable")then{
    _man disableAI "AIMINGERROR";
};

true;