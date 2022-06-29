private _actionText = "none";
params["_man", "_actionText"];
private _timer = time + 3;
private _standAnim 	= "AmovPercMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon";
private _crouchAnim	= "AmovPknlMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon";

[_man, "action", "emergency heal"] call SFSM_fnc_unitData;
[_man, _actionText] call SFSM_fnc_endHealEH;

switch (stance _man) do
	{
		case "STAND" :	{_man playMove _standAnim };
		case "CROUCH": 	{_man playMove _crouchAnim};
	};

waitUntil{
			sleep 0.1;
			((stance _man) == "prone"
			or !alive _man
			or time > _timer)
		};

_man action ["HealSoldierSelf", _man];