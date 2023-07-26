params["_man", "_victim"];
if(_man distance2D _victim > 5)          exitWith{false;};
if!([_man, true] call SFSM_fnc_canRun)   exitWith{false;};
if([_victim, true] call SFSM_fnc_canRun) exitWith{false;};
if([_victim] call SFSM_fnc_isUncon)      exitWith{false;};
if(!alive _victim)                       exitWith{false;};

private _loadOut = _victim getVariable "SFSM_loadOut";
if(isNil "_loadOut")exitWith{false;};


true;