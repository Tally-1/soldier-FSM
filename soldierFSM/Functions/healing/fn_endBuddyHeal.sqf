params["_healer", "_wounded", "_success"];

private _status = "successful!";
if!(_success)then{_status = "failed!";};
private _actionText = ["healing ", _status] joinString "";

_healer  enableAI "path";
_wounded enableAI "path";

[_healer, "action", _actionText] call SFSM_fnc_unitData;
[_wounded, "action", _actionText] call SFSM_fnc_unitData;

sleep 2;

[_healer, "action", "none"] call SFSM_fnc_unitData;
[_wounded, "action", "none"] call SFSM_fnc_unitData;



true;