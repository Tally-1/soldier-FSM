// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _time = 1;
params["_man", "_flashText", "_time"];

if(SFSM_Debugger isEqualTo false)exitWith{};

private _flashAction = [_man, "flashAction"] call SFSM_fnc_unitData;

if(isNil "_flashAction")         exitWith{};
if(_flashAction isNotEqualTo "") then{
	private _startTime = time;
	waitUntil{
		private _flashAction = [_man, "flashAction"] call SFSM_fnc_unitData;
		if(isNil "_flashAction")      exitWith {true;};
		if(_flashAction isEqualTo "") exitWith {true;};
		false;
	};

	private _timeSpent = time - _startTime;
	private _time = _time - _timeSpent;
	if(_time < 0.2)then{_time = 0.2;};
};

["flash_action", [_man, _flashText]] call CBA_fnc_localEvent;

[_man, "flashAction", _flashText] call SFSM_fnc_unitData;

sleep _time; 
[_man, "flashAction", ""] call SFSM_fnc_unitData;

true;