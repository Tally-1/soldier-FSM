private _decimals = 0;
params["_position", "_decimals"];

private _pos = [([(_position # 0), _decimals] call Tcore_fnc_decimals), 
				([(_position # 1), _decimals] call Tcore_fnc_decimals), 
				([(_position # 2), _decimals] call Tcore_fnc_decimals)];

_pos