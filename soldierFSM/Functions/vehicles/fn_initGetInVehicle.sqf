params["_vehicle", "_man"];

private _actionText = ["Getting vehicle as ", _role, "!"] joinString "";
[_man, "action", _actionText]call SFSM_fnc_unitData;

private _targetedBy = _vehicle getVariable "targetedBy";

if(isNil "_targetedBy")
then{
	_vehicle setVariable ["targetedBy", []];
};
(_vehicle getVariable "targetedBy")pushBackUnique _man;

true;