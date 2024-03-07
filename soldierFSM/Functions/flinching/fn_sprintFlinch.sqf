params[
	["_man", nil, [objNull]]
];

private _sprintDir = [_man] call SFSM_fnc_evasionDir2;

if(isNil "_sprintDir")exitWith{
	[_man, "lastFlinchSprint", time] call  SFSM_fnc_unitData;
	[_man, "Nowhere to run!",0.5]    spawn SFSM_fnc_flashAction;
	false;
};

[_man, "action", "flinch-sprint"] call SFSM_fnc_unitData;
[_man, "lastFlinchSprint", time]  call SFSM_fnc_unitData;
["flinch_sprint", [_man]]         call CBA_fnc_localEvent;

private _postFnc = { 
    params["_man"];
    [_man, "amovppnemstpsraswrfldnon"] remoteExecCall ["playMoveNow", _man];
	[_man, "lastFlinch", time] call SFSM_fnc_unitData;
	[_man, "none"]             call SFSM_fnc_setAction;
	_man setUnitPos "DOWN";
    true;
};
private _move = "AmovPercMevaSlowWrflDf";

_man setDir _sprintDir;
getpos _man;

[
    _man, 
    _move,
    [
        [_man],
        false,
        _postFnc
    ]
] call SFSM_fnc_animThenExec;

true;