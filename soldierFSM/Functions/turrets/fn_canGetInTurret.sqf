params["_man", "_turret"];
private _battleKey   = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battlefield = SFSM_battles get _battleKey;

if!(alive _man)                                   exitWith{false;};
if(_man distance2D _turret > 5)                   exitWith{false;};
if(_man getVariable ["ace_isunconscious", false]) exitWith{false;};
if(_man getVariable ["dam_ignore_injured0",false])exitWith{false;};
if!([_turret, true] call SFSM_fnc_turretAvailable)exitWith{false;};
if(isNil "_battlefield")                          exitWith{false;}; 

true;