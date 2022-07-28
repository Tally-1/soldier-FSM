/*
	DESCRIPTION:
	called from battlefieldPostInit, sends units to nearest coverPos if available.
*/
params ["_man", "_battlefield"];

private _enemy         = ([_man, nil, 'enemies'] call Tcore_fnc_nearKnownEnemies)#0;
private _pathEnabeled  = [_man, 'pathEnabeled'] 	call SFSM_fnc_unitData;

if!(_pathEnabeled)exitwith{"path disabeled, unit will not take cover" call SFSM_fnc_debugMessage};


private _coverPos    = [_man] call SFSM_fnc_getCoverPos;
private _posFound    = ((!isNil "_coverPos") && {typeName _coverPos == "Array"});
private _enemyFound  = ((!isNil '_enemy') && {(!isNull _enemy)});
private _panic       = (random 1) < SFSM_panicCoef;
private _canDodge    = [_man] call SFSM_fnc_canDodge;

if((!(_posFound ))
&& {_panic 
&& {SFSM_noCoverPanic}})
exitWith
{
	[_man] spawn SFSM_fnc_eyelidTrench;
};

if((!_posFound) 
&&{_canDodge
&&{_enemyFound}})
exitWith{[_man, _enemy] spawn SFSM_fnc_dodge};

if(_posFound)exitWith{[_man, _coverPos] spawn SFSM_fnc_takeCover};

"No pos, no panic" call dbgmsg;