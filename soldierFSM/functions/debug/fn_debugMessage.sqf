private _displayType = 1; //2 = hint, 1 = systemChat
params["_text", "_displayType"];

private _returnVal =
[_text, SFSM_Debugger, SFSM_Debugger, _displayType, "Soldier FSM -->  "]
call Tcore_fnc_debugMessage;

_returnVal;