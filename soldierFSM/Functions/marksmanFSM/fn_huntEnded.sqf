params ["_marksman", "_target"];
if!([_marksman, _target] call SFSM_fnc_viableTarget) exitWith{true};
if!([_marksman] call SFSM_fnc_hasAmmoForWeapon)      exitWith{true};
if!(alive _marksman)                                 exitWith{true};
if ([_marksman] call SFSM_fnc_isUncon)               exitWith{true};


private _mrkmBattle = [_marksman] call SFSM_fnc_getBattlefield;
private _trgtBattle = [_marksman] call SFSM_fnc_getBattlefield;

if(isNil "_mrkmBattle"
&&{isNil "_trgtBattle"})
exitWith{true};

private _startTime = [_marksman, "huntStart"] call SFSM_fnc_unitData;
if(time - _startTime > SFSM_maxHuntTime)exitWith{true};

false;