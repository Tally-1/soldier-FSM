params["_man"];
private _target     = getAttackTarget _man;
private _targetList = [];
private _visible    = false;

private _atTarget = [_man] call SFSM_fnc_getFipoATtarget;
if(!isNull _atTarget)exitwith{ 
    [_man, "Targeting Vehicle"] call SFSM_fnc_flashAction;
    ["Targeting vehicle from fipo", 2]call dbgmsg;
    _atTarget;
};


if(alive _target)then{
    _visible = [_man, _target, 0.1, true] call SFSM_fnc_targetVisible;
};

if!(_visible)then{
    private _lastShooter = _man getVariable "SFSM_prevShooter";
    private _lastTarget  = _man getVariable "SFSM_prevTarget";
    private _enemies     = ([_man, 400] call SFSM_fnc_nearEnemies);
    
    if([_man, _lastShooter] call SFSM_fnc_validEnemy)then{_enemies pushBackUnique _lastShooter};
    if([_man, _lastTarget]  call SFSM_fnc_validEnemy)then{_enemies pushBackUnique _lastTarget};

    _targetList  = [_man, _enemies] call SFSM_fnc_targetsAndVisibility;
    
    if(_targetList isEqualTo [])exitwith{_target = objNull;};

    [_man, "Target reassigned"] call SFSM_fnc_flashAction;
    _target = _targetList#0#0;
};

if(isNull _target)exitWith{};

_target;