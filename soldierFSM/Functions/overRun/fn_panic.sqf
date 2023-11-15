params["_man"];
[_man, "!PANIC!"] call SFSM_fnc_setAction;
private _loadout = getUnitLoadout _man;

_man setVariable ["SFSM_loadout", _loadout];
_man setVariable ["SFSM_panic", true, true];
_man disableAI "all";

//play first panic animation
private _panicMove = selectRandom SFSM_panicMoveAnims;
private _animHandle = ([_man, _panicMove] call SFSM_fnc_animThenExec)#0;

//wait until animation has completed, and delete handle-variable
waitUntil{sleep 0.1; _man getVariable _animHandle};
_man setVariable [_animHandle, nil];
_man switchMove "AmovPercMstpSnonWnonDnon";


//animate then execute weapon drop
_animHandle = ([
    _man,
    "AmovPercMstpSrasWrflDnon_AinvPknlMstpSlayWrflDnon",
    [
        [_man, true], 
        true,
        SFSM_fnc_dropAllWeapons
    ]
] call SFSM_fnc_animThenExec)#0;

waitUntil{
    sleep 1; 
    private _animDone = _man getVariable _animHandle;
    if(isNil "_animDone")        exitWith{true;};
    if(_animDone isEqualTo true) exitWith{true;};
    false;
};

_man setVariable [_animHandle, nil];

//final stage of panic
private _panicAnim = selectRandom SFSM_panicAnimations;

_man switchMove "ApanPercMstpSnonWnonDnon_ApanPknlMstpSnonWnonDnon";
_man playMove _panicAnim;
_man setCaptive true;


[_man] call SFSM_fnc_panicAction;
[_man]  remoteExecCall ["SFSM_fnc_captureAction", 0];

// Sometimes the animation glitches out, this repeats it in case that happens.
[_man, _panicAnim] spawn {
    sleep 3;
    if(animationState (_this#0) != (_this#1))then{
        _this#0 playMove (selectRandom SFSM_panicAnimations);
    };
};