params["_battleField"];
if!(SFSM_aceLoaded)exitWith{["Ace not loaded",2] call dbgmsg;};
["Starting med-loop",2] call dbgmsg;

while {!isNil "_battleField"} do {
	private _script = [_battleField] spawn SFSM_fnc_battleFieldMedical;
	waitUntil {
			sleep 1;
			private _finito = scriptDone _script;
			if(isNil "_finito")exitWith{true;};
			_finito; 
	};

	private _units             = missionNamespace getVariable (_battlefield get "units");
	if(isNil "_units")exitWith{};
	
	sleep 10;
};

["Ending med-loop",2] call dbgmsg;

true;