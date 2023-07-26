params["_man", "_enemies"];
private _leader  = (leader group _man);
private _target  = getAttackTarget _man;
private _timer   = time+120;
private _fipo    = _man getVariable "SFSM_prevFipo";
private _counter = "true";

[_man, "Counter Attacking"] call SFSM_fnc_setAction;
["overrun_attack",  [_man, _enemies]] call CBA_fnc_localEvent;


if!(_target in _enemies)then{
    _target = [_man, _enemies] call SFSM_fnc_getNearest;
};

while {_counter isEqualTo "true"} do {
    if(isNil "_target")                       exitWith{_counter = "error";};
    if(isNil "_man")                          exitWith{_counter = "error";};
    
    if(_man distance _target > 2)then{
        _man doMove (getPosATLVisual _target);
    };
    
    _man doFire _target;
    sleep 5;

    if!([_target, true] call SFSM_fnc_canRun) exitWith{_counter = "target down";};
    if!([_man, true] call SFSM_fnc_canRun)    exitWith{_counter = "I am down";};
    if(time>_timer)                           exitWith{_counter = "Timed out";};

    _enemies = [_man] call SFSM_fnc_nearEnemies;
    _target  = [_man, _enemies] call SFSM_fnc_getNearest;
};

[_man, "none"]   call SFSM_fnc_setAction;
[_man, _counter] spawn SFSM_fnc_flashAction;
_man doFollow _leader;

if([_man, true] call SFSM_fnc_canRun
&&{_counter isEqualTo "target down"
&&{!isNil "_fipo"
&&{[_fipo] call SFSM_fnc_fipoAvailable}}})
then{
    sleep 0.1;
    [_man, _fipo, true] spawn SFSM_fnc_moveInFipo;
    sleep 0.1;
};

true;