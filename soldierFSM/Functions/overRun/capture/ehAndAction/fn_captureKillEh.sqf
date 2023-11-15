params ["_man"];
private _eh =
_man addEventHandler ["Killed", { 
    params ["_man", "_killer", "_instigator", "_useEffects"];
    [_man, "Acts_executionvictim_Kill_End"] remoteExecCall ["switchMove",0];
    
    _man removeEventHandler [_thisEvent, _thisEventHandler];
}];

_man setVariable ["SFSM_captureKillEh", _eh];

true;