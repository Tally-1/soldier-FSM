params["_man"];

// private _anims = [
//     "Acts_AidlPercMstpSlowWrflDnon_pissing",
//     "Acts_AidlPercMstpSnonWnonDnon_warmup_7_loop",
//     "Acts_AidlPercMstpSloWWrflDnon_warmup_6_loop",
//     "Acts_AidlPercMstpSloWWrflDnon_warmup_8_loop",
//     "Acts_Ambient_Cleaning_Nose"
// ];

// private _anim = selectRandom _anims;
private _idleAnims = call compile FIPO_idleAnimations;
private _anim      = selectRandom _idleAnims;//(["Acts_AidlPercMstpSlowWrflDnon_warmup0", (ceil random 5)]joinString"");
private _timer     = time + 30;
_man setVariable ["SFSM_idleAnim", _anim];

[_man] call SFSM_fnc_idleAnimEh;
[_man, "Idle"] call SFSM_fnc_setAction;

_man setAnimSpeedCoef 1;
_man playMoveNow _anim;
sleep 0.2;
_man setDir getDir([_man] call SFSM_fnc_getFipo);

waitUntil{
    sleep 0.2;
    
    private _animDone = (_man getVariable ["SFSM_idleAnimDone", false]);
    private _timedOut = time > _timer;
    if(_animDone) exitWith {true;};
    if(_timedOut) exitWith {true;};

    false;
};

private _eh = _man getVariable "SFSM_idleAnimEh";
if(!isNil "_eh")then{
    _man removeEventHandler ["AnimDone", _eh];
    _man setVariable ["SFSM_idleAnimEh", nil];
    _man setVariable ["SFSM_idleAnim", nil];
};

true;