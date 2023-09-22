while {sleep 0.5; true} do {
	//Should be light enough to run every 0.5 seconds...
	[] spawn{isNil{[] call SFSM_fnc_handleActivationZones;}};

};