params["_man"];

_man getVariable "SFSM_Ace_ExecuteActionData"
params["_parentPath", "_actionName"];

[_man, _parentPath, _actionName] remoteExec ["SFSM_fnc_ACE_removeObjectAction", 0];

_man setVariable ["SFSM_Ace_ExecuteActionData", nil, true];

true;