params["_fipo"];

[_fipo] call SFSM_fnc_fipoDefineSides;
// [_fipo] call SFSM_fnc_fipoMarker;
[_fipo] call SFSM_fnc_moveInFipoSynced;

if(_fipo getVariable "dynamicFipo") then{_fipo setVariable ["active", false];};
if(_fipo getVariable "AZ_FIPO")     then{_fipo setVariable ["active", false];};

if(SFSM_debugger)then{
	private _low  = _fipo getVariable "coverstance";
	private _high = _fipo getVariable "shootingStance";

	if(_low isEqualTo _high)then{
		"Fighting position with equal low and high stances detected" call dbgmsg;
	};

	if(_low > _high)then{
		"Fighting position with cover-pos higher than shooting-pos detected" call dbgmsg;
	};
};

_fipo setVectorUp [0,0,1];

true;