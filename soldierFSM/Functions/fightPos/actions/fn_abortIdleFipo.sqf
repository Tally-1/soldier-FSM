params["_man"];
private _eh = _man getVariable "SFSM_idleAnimEh";
if(!isNil "_eh")then{
    _man removeEventHandler ["AnimDone", _eh];
    _man setVariable ["SFSM_idleAnimEh", nil];
    _man setVariable ["SFSM_idleAnim",   nil];
};

_man playMoveNow "AmovPercMstpSrasWrflDnon";
_man enableAI "anim";