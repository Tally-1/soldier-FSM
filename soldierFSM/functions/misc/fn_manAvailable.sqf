params["_man", "_timer"];

private _action   = [_man, "action"] call SFSM_fnc_unitData;
private _timedOut = time > _timer;

if(!alive _man)		 exitwith{true};
if(_timedOut)        exitwith{true};
if(isNil '_action')  exitwith{true};
if(_action == "none")exitwith{true};
false;