params ["_man"];
	sleep 1.2;
	[_man, "flinching", false] 	call SFSM_fnc_unitData;
	[_man, "action", "none"] 	call SFSM_fnc_unitData;
	_man enableAI "FSM";

if ((stance _man) == "PRONE")
then{
	_man playMove "AmovPercMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon";
};