addMissionEventHandler ["Loaded", {
	params ["_saveType"];
	[] spawn {
		if(isMultiplayer)then{
			sleep 20;
			private _text= [] call SFSM_fnc_gameLoadedWarning;
			hint _text;
		};
	};
}];