params ["_man", "_battlefield", "_objectHash"];

private _script = [_man, _battlefield, _objectHash] spawn SFSM_fnc_initHunkerFSM;
waitUntil{sleep 0.5; scriptDone _script};

private _action = [_man, "action"] call SFSM_fnc_unitData;

if(_action == "cannot reach hunker pos")exitWith{
	sleep 1.5;
	[_man, _objectHash, _action] call SFSM_fnc_endHunker;
};

if(_man getVariable ["ace_isunconscious", false])exitWith{
	sleep 1.5;
	[_man, _objectHash, _action] call SFSM_fnc_endHunker;
};

private _side = side _man;
private _timer = time + 120;
private _endText = "";


while {true} do {

	if(_timer < time)exitWith{_endText = "timed out"};
	if(!alive _man)exitWith{_endText = "died"};
	if(isNil "_battlefield")exitWith{_endText = "battle ended"};

	_enemyPositions = [_side, _battlefield] call SFSM_fnc_getEnemyPositions;

	if(isNil "_enemyPositions")exitWith{_endText = "no enemy positions"};
	if(count _enemyPositions < 1)exitWith{_endText = "no enemy positions"};

	[_objectHash, _enemyPositions] call SFSM_fnc_setHobjPositions;
	[_man, _objectHash, _enemyPositions] call SFSM_fnc_hunkerFsmStatus;

	_script = [_man, _objectHash, _battlefield] spawn SFSM_fnc_handleHunkerStatus;
	waitUntil{sleep 0.5; scriptDone _script};

	private _action = ([_man, "action"] call SFSM_fnc_unitData);
	private _noTarget = _action == "wait, cannot aquire target from hunker-pos";
	private _status = (_action splitString " ")#0;
	
	
	if('hiding' in _action)exitWith{_endText = "hiding from vehicle"};
	if(_status == "end")exitWith{_endText = "no enemies"};

	if(_status == "displace,")exitWith{_endText = "displacing"};

	if(_status == "fired!")then{_timer = _timer + 15};

	private _safePos = _objectHash get "safe_pos";
	_man doMove _safePos;

	private _randomSleep = round(random 15);
	sleep _randomSleep;

	if(_status == "wait," 
	&&{! _noTarget})then{_timer = _timer + _randomSleep};

	if(_noTarget)then{_timer = _timer - 10};
};

if(_endText == "displacing")
exitWith{
			sleep 1;
			[_man, _objectHash, _endText] call SFSM_fnc_endHunker;
			sleep 1;
			private _canDisplace = [_man] call SFSM_fnc_initHunker;
			sleep 1;
			if(_canDisplace)
			then{[_man, "action", "Displacing to new hunkerPos"] call SFSM_fnc_unitData};
		};

[_man, _objectHash, _endText] call SFSM_fnc_endHunker;
