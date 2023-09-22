params["_man"];
[_man, "inFipo", false] call SFSM_fnc_unitData;
[_man] call SFSM_fnc_abortIdleFipo;
_man setAnimSpeedCoef 1;

_man enableAI "all";
_man setUnitPos "AUTO";

private _action = [_man] call SFSM_fnc_getAction;
private _fipo   = [_man] call SFSM_fnc_getFipo;
private _noFipo =  isNil "_fipo";

if(_noFipo
&&{_action isNotEqualTo "none"})exitWith{
	[["Man got out of non-existing fipo. Action: ", _action], 2] call dbgmsg;
	[_man, "none"] call SFSM_fnc_setAction;
};

if(_noFipo)exitWith{};

private _azFipoData = _fipo getVariable "azFipoData";
if(!isNil "_azFipoData")then{_azFipoData set ["owner", objNull];};

[_fipo] call SFSM_fnc_clearFipo;
[_fipo] call SFSM_fnc_updateFipoMarker;
[_man]  call SFSM_fnc_abortIdleFipo;
_man setVariable ["SFSM_prevFipo", _fipo];

if((toLowerANSI _action) in SFSM_fipoActions)then{
	[_man, "none"] call SFSM_fnc_setAction;
}else{
	[["Fipo get out action: ", _action], 2] call dbgmsg;
};

//de-init hit and run FIPOS.
if(_fipo getVariable "hitAndRun")then{
	[_man, _fipo] call SFSM_fnc_endHitAndRun;

};

_man doFollow (leader group _man);
["fipo_getOut", [_man, _fipo]] call CBA_fnc_localEvent;

//some delay in the targeting function sometimes causes the man to be assigned an action even after he gets out.
_man spawn{
	sleep 2;
	private _action = toLowerANSI ([_this] call SFSM_fnc_getAction);
	if(_action in SFSM_fipoActions)then{
		[_this, "none"] call SFSM_fnc_setAction;
	};
	true;
};

true;