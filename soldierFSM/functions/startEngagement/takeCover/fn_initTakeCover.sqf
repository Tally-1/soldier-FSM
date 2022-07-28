params ["_man"];
private _timer  = time + 5;
private _available = [_man, _timer] call SFSM_fnc_manAvailable;

if!(_available)
then{
		waitUntil { 
					sleep 0.1;
					[_man, _timer] call SFSM_fnc_manAvailable;
				  };
	};