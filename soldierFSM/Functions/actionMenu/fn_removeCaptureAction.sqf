params ["_man"];
if(SFSM_aceLoaded) exitWith{
   [_man] call SFSM_fnc_ACE_removeCaptureAction;
};
private _actionId = _man getVariable "SFSM_captureAction";

_man removeAction _actionId;

true;