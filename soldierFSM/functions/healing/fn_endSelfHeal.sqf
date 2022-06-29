private _actionText = "none";
params ["_man", "_eh", "_actionText"];
private _damage  = damage _man;
private _timeOut = time + 10;
waitUntil { damage _man != _damage or time > _timeOut };
[_man, "action", _actionText] call SFSM_fnc_unitData;

if!("hunker" in _actionText)then{_man setUnitPos "AUTO"};

_man removeEventHandler ["HandleHeal", _eh];