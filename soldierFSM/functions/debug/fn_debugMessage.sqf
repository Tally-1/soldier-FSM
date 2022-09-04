private _displayType = 1; //2 = hint, 1 = systemChat
params["_text", "_displayType"];

if(isNil "SFSM_Version")then{SFSM_Version = 0.297};

private _signature = ["Soldier FSM V.", SFSM_Version," -->  "] joinString "";

private _returnVal =
[_text, SFSM_Debugger, SFSM_Debugger, _displayType, _signature]
call Tcore_fnc_debugMessage;

_returnVal;