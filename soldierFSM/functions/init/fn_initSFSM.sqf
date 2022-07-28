if(is3DEN)exitWith{};

if((!isNil "SFSM_disableSoldierFSM")
&&{SFSM_disableSoldierFSM})
exitWith{
			["SOLDIER FSM Has been disabeled!!", true, true, 2, "--SFSM ShutDown--"] 
			call Tcore_fnc_debugMessage;
		};

//for ease of writing I have shortened the name of the debugMessage function.
if(isNil "dbgmsg")
then{dbgmsg = SFSM_fnc_debugMessage};


if(isServer)	then{[] spawn SFSM_fnc_serverInit};
if(hasInterface)then{[] call SFSM_fnc_initClient};

if(isNil 'ObjScan_Fnc_average')
then{hint "DCO unitScanner not detected, Soldier FSM will not function properly."};

