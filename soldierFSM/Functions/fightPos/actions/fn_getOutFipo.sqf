params["_man"];
[_man, "inFipo", false] call SFSM_fnc_unitData;
[_man] call SFSM_fnc_abortIdleFipo;
_man setAnimSpeedCoef 1;

_man enableAI "all";
_man setUnitPos "AUTO";
[_man, "none"] call SFSM_fnc_setAction;

private _fipo = [_man] call SFSM_fnc_getFipo;
if(isNil "_fipo")exitWith{};

[_fipo] call SFSM_fnc_clearFipo;
[_fipo] call SFSM_fnc_updateFipoMarker;
[_man]  call SFSM_fnc_abortIdleFipo;
_man setVariable ["SFSM_prevFipo", _fipo];

if(_fipo getVariable "hitAndRun")then{
	_fipo setVariable ["SFSM_lastVisit", time];
	_fipo setVariable ["SFSM_firstShot", nil];
};

private _firedEh = (_man getVariable "SFSM_fipoFiredEh");
if(!isNil "_firedEh")then{
	_man removeEventHandler ["Fired", _firedEh];
	_man setVariable ["SFSM_fipoFiredEh", nil];
};

_man doFollow (leader group _man);

["fipo_getOut", [_man, _fipo]] call CBA_fnc_localEvent;

//some delay in the targeting function sometimes causes the man to be assigned an action even after he gets out.
_man spawn{
	sleep 2;
	if([_this] call SFSM_fnc_getAction in ["Engaging target", "In cover"])then{
		[_this, "none"] call SFSM_fnc_setAction;
	};
	true;
};
true;