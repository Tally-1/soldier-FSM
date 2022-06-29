if(isServer)	then{[] spawn SFSM_fnc_serverInit};
if(hasInterface)then{[] call SFSM_fnc_initClient};

if(isNil 'ObjScan_Fnc_average')
then{hint "DCO unitScanner not detected, Soldier FSM might not function properly."};