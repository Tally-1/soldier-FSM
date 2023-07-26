private _execParams = [[],true,{}];
private _switch     = false;
params[
    "_man",        //Object type CaManBase
    "_anim",       //string (animation-name)
    "_execParams", //[[params], true/false(scheduled), fnc_name/{code}]
    "_switch"      // boolean
];
private _animHandle = ["SFSM_animDone_", _anim] joinstring "";

if(_switch)
then{[_man, _anim] remoteExecCall ["switchMove", 0];}
else{[_man, _anim] remoteExecCall ["playMoveNow", 0];};



_man setVariable ["SFSM_wantedExecAnim",   toLowerANSI _anim];
_man setVariable ["SFSM_animHandle",       _animHandle];
_man setVariable ["SFSM_wantedExecParams", _execParams];
_man setVariable [_animHandle, false];

private _eventHandler = 
_man addEventHandler ["AnimDone", {
    params ["_man", "_anim"];
    _this append [_thisEvent, _thisEventHandler];
    _this call SFSM_fnc_onExecAnim;
}];

[_animHandle, _eventHandler];