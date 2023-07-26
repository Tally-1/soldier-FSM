waitUntil {!isNil "SFSM_Debugger"};
if(SFSM_DebugType isEqualTo "never")  exitwith{SFSM_Debugger = false;};
if(SFSM_DebugType isEqualTo "always") exitwith{SFSM_Debugger = true;};

while {true} do {
		sleep 1;
		SFSM_Debugger = [] call SFSM_fnc_isDebugActive;
	};