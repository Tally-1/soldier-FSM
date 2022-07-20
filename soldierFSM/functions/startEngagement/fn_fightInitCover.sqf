/*
	DESCRIPTION:
	called from battlefieldPostInit, sends units to nearest coverPos if available.
*/
params ["_man", "_battlefield"];

private _radius        = SFSM_DodgeDistance;
private _unitPos       = getPos _man;
private _searchPos     = _unitPos;
private _dirToEnemy    = [_man] call Tcore_fnc_knownDirToEnemy;
private _enemyDirFound = !(isNil '_dirToEnemy');
private _enemy         = objNull;
private _pathEnabeled  = [_man, 'pathEnabeled'] 	call SFSM_fnc_unitData;

if!(_pathEnabeled)exitwith{"path disabeled, unit will not take cover" call SFSM_fnc_debugMessage};
// if((leader (group _man)) in allPlayers)exitwith{"PlayerGroup, not taking cover" call SFSM_fnc_debugMessage};

if(_enemyDirFound)
then{
			private _randomDir     = selectRandom[90,-90];
			private _searchDir  = [(_dirToEnemy + _randomDir)] call Tcore_fnc_formatDir;
			
			_radius = SFSM_DodgeDistance / 2;
			_searchPos = [_unitPos#0, _unitPos#1, _searchDir, _radius] call Tcore_fnc_sinCosPos;
			_enemy = ([_man, nil, 'enemies'] call Tcore_fnc_nearKnownEnemies)#0;
		};

private _coverPos = [_man, _searchPos, _radius] call SFSM_fnc_getCoverPos;
private _posFound = (!isNil "_coverPos" && {typeName _coverPos == "Array"});
private _panic    = (random 1) > 0.5;
private _canDodge = [_man] call SFSM_fnc_canDodge && (!isNull _enemy);

if((!(_posFound ))
&& {_panic 
&& {SFSM_noCoverPanic}})exitWith{[_man] spawn SFSM_fnc_eyelidTrench};

if!(_posFound && _canDodge)exitWith{[_man, _enemy] spawn SFSM_fnc_dodge};

[_man, _coverPos] spawn SFSM_fnc_takeCover;