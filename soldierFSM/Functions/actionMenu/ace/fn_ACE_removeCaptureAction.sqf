params ["_man"];
private _data = _man getVariable "SFSM_Ace_CaptureActionData";
if(isNil "_data")exitWith{"unknown capture data" call dbgMsg;};

_data params["_parentPath", "_actionName"];
[_man, _parentPath, _actionName] call SFSM_fnc_ACE_removeObjectAction;
_man setVariable ["SFSM_Ace_CaptureActionData", nil, true];

true;