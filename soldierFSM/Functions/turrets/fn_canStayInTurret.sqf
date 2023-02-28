params ["_man", "_turret", "_forceLeave"];
private _leader      = leader (group _man);
private _turret      = vehicle _man;
private _battleKey   = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battlefield = SFSM_battles get _battleKey;

if(_forceLeave)                                       exitwith{false;};
if(_man == _leader)                                   exitwith{false;};
if(_turret == _man)                                   exitwith{false;};
if(!canFire _turret)                                  exitwith{false;};
if(damage _turret > 0.9)                              exitWith{false;};
if(isNil "_battlefield")                              exitWith{false;};
if(_turret distance2D _leader > SFSM_turretLeaderDist)exitwith{false;};

true;