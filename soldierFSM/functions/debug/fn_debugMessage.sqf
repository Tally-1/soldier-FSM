// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _displayType = 1; //2 = hint, 1 = systemChat
params["_text", "_displayType"];

private _signature = ["Soldier FSM V.", SFSM_Version," -->  "] joinString "";

private _log = SFSM_Debugger;

if((! _log) 
&&{SFSM_DebugType isEqualTo "curator"})then{
	_log = true;
};


private _returnVal =
[_text, SFSM_Debugger, _log, _displayType, _signature]
call Tcore_fnc_debugMessage;

_returnVal;