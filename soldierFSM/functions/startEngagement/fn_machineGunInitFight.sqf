params ["_man"];

if!(SFSM_mgSuppressClusters)
exitWith{"initial suppression has been deactivated in CBA options" call dbgmsg};

private _battleKey = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battlefield = SFSM_Battles get _battleKey;

if(isNil "_battlefield")exitWith{};

private _side          = side _man;
private _allClusterPos = (_battlefield get "clusterPositions");
private _coverPos      = [_man] call SFSM_fnc_getCoverPos;
private _coverPosFound = ((!isNil "_coverPos") && {typeName _coverPos == "ARRAY"});

"starting suppression" call SFSM_fnc_debugMessage;




[_man, "action", "!!! Suppressing enemy !!!"] call SFSM_fnc_unitData;

private _enemyClusterPositions = [_side, _battlefield] call SFSM_fnc_getEnemyPositions;
private _script = [_man, _enemyClusterPositions] spawn SFSM_fnc_supressPositions;
waitUntil {sleep 0.5; scriptDone _script};

if(isNil "_battlefield")exitWith{[_man, "action", "none"] call SFSM_fnc_unitData};

//move to coverposition if possible
if(! _coverPosFound)
then{
		_coverPos      = [_man] call SFSM_fnc_getCoverPos;
		_coverPosFound = ((!isNil "_coverPos") && {typeName _coverPos == "ARRAY"});
	};
	
if(_coverPosFound
&&{_man distance2D _coverPos > 2.5})
then{
		[_man, "action", "Suppressing and Moving"] call SFSM_fnc_unitData;
		_script = [_man, _coverPos, 3] spawn SFSM_fnc_forceMoveToPos;
		waitUntil {sleep 1; scriptDone _script};
	};
	
sleep 2;

[_man, "action", "Suppressing enemy positions"] call SFSM_fnc_unitData;

if(isNil "_battlefield")exitWith{[_man, "action", "none"] call SFSM_fnc_unitData};

//now suppress every single enemy individually
private _radius = _battlefield get "radius";
private _allEnemyPos = [_man, (_radius*2)] call Tcore_fnc_nearKnownEnemies;
private _script = [_man, _allEnemyPos] spawn SFSM_fnc_supressPositions;
waitUntil {sleep 0.5; scriptDone _script};

if(isNil "_battlefield")exitWith{[_man, "action", "none"] call SFSM_fnc_unitData};

if(_coverPosFound
&&{_man distance2D _coverPos > 2.5})
then{
		[_man, "action", "Suppressing and Moving"] call SFSM_fnc_unitData;
		_script = [_man, _coverPos, 3] spawn SFSM_fnc_forceMoveToPos;
		waitUntil {sleep 1; scriptDone _script};
	};

"machineGunner ended suppression of enemy" call SFSM_fnc_debugMessage;
[_man, "action", "none"] call SFSM_fnc_unitData;
_man doFollow leader (group _man);

[_man] call SFSM_fnc_postCoverActions;
true;