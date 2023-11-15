params["_man"];
if(SFSM_aceLoaded) exitWith{
   [_man] remoteExecCall ["SFSM_fnc_ACE_removeExecuteAction", 0];
};
private _actionId = _man getVariable "SFSM_executeAction";

_man removeAction _actionId;

true;