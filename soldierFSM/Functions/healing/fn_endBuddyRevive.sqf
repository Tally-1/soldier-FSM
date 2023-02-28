params["_healer", "_unconscious", "_success"];

private _status = "successful!";
if(_success)then{_unconscious switchMove "AmovPpneMstpSrasWrflDnon";}
			else{_status = "failed!";};


private _actionText = ["revive ", _status] joinString "";
[_healer, "action", _actionText] call SFSM_fnc_unitData;
[_unconscious, "action", _actionText] call SFSM_fnc_unitData;

sleep 2;

[_healer, "action", "none"] call SFSM_fnc_unitData;
[_unconscious, "action", "none"] call SFSM_fnc_unitData;

true;