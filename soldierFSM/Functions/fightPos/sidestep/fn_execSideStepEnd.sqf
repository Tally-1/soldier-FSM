params[
    ["_man", nil, [objNull]]
];
private _fipoDir     = _man getVariable ["SFSM_fipoDir",    (getDirVisual _man)];
private _returnStep  = _man getVariable ["SFSM_returnStep",  false];
private _stepEndAnim = _man getVariable ["SFSM_stepEndAnim", (animationState _man)];

_man setDir _fipoDir;

if(_returnStep)then{[_man]spawn{params["_man"];
    sleep 1;
    [_man, "fipo-sidestep", false] call SFSM_fnc_unitData;
}};

[_man]                          call SFSM_fnc_fixPos;
[_man, "peekCooldown", time+10] call SFSM_fnc_unitData;

_man setVariable ["SFSM_ignoreFipo",  nil];
_man setVariable ["SFSM_returnStep",  nil];
_man setVariable ["SFSM_stepEndAnim", nil];
_man setVariable ["SFSM_fipoDir",     nil];

_man setDir _fipoDir;
_man enableAI "anim";
_man enableAI "move";
_man enableAI "fsm";

true;