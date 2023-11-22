params["_man"];
private _killEh  = _man getVariable "SFSM_captureKillEh";
private _hitEh   = _man getVariable "SFSM_captureHitEh";
private _group   = _man getVariable ["SFSM_OriginalGroup", grpNull];
private _loadOut = _man getVariable "SFSM_loadout";

[_man] call SFSM_fnc_removeExecuteAction;

if(!isNil "_killEh") then {_man removeEventHandler ["Killed", _killEh];};
if(!isNil "_hitEh")  then {_man removeEventHandler ["Hit",    _hitEh];};

if(!alive _man)exitWith{};

if(isNull _group)then{
	_group = createGroup (side _man);
};

SFSM_cleanupObjs deleteAt (SFSM_cleanupObjs find _man);
_man setVariable ["SFSM_OriginalGroup", nil];
_man enableAI "all";
_man setCaptive false;

if(!isNil "_loadOut")then{
	_man setUnitLoadout _loadOut;
	_man setVariable ["SFSM_loadout", nil];
};

[_man, "none"] call SFSM_fnc_setAction;

if("executionvictim" in animationState _man
&&{alive _man})then{
	_man switchMove "Acts_ExecutionVictim_Unbow";
};


if!(_man in allPlayers)then{[_man] join _group;};

true;