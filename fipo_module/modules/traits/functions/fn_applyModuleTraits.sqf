params["_module", "_man"];


if(_module getVariable "excluded_sfsm")exitWith{
	_man setVariable ["SFSM_Excluded", true, true];
};

private _isLeader    = leader group _man isEqualTo _man;
if(_isLeader)then{
	private _commandSkill = _module getVariable "command";
	_man setSkill ["commanding", _commandSkill];
};

_man setSkill ["aimingAccuracy", (_module getVariable "aimaccuracy")];
_man setSkill ["aimingSpeed",    (_module getVariable "aimspeed")];
_man setSkill ["aimingShake",    (_module getVariable "aimshake")];
_man setSkill ["spotDistance",   (_module getVariable "spotdistance")];
_man setSkill ["spotTime",       (_module getVariable "spottime")];
_man setSkill ["reloadSpeed",    (_module getVariable "reloadspeed")];
_man setSkill ["courage",        (_module getVariable "courage")];

if(_module getVariable "aimingErrorDisable")then{
	_man disableAI "AIMINGERROR";
};

true;