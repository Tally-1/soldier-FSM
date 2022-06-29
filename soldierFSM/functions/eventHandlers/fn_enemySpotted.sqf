params ["_leader", "_group"];
if!((side _group) in [east, west, independent])exitWith{objNull};


private _battle       = [_group, "currentBattle"] call SFSM_fnc_groupData;
private _lastSpotting = [_group, "lastSpotting"]  call SFSM_fnc_groupData;

if(isNil "_battle")			 exitWith{objNull};
if!(_battle == "none")		 exitWith{objNull};
if(time - _lastSpotting < 30)exitWith{objNull};
if(!alive _leader)			 exitWith{objNull};

private _currentEnemy   = _leader findNearestEnemy _leader;
private _lastKnownEnemy = _group getVariable "SFSM_lastKnownEnemy";


_group setVariable["lastKnownEnemy", _currentEnemy];

if(isNull _currentEnemy)				  exitWith{objNull};
if!(_group knowsAbout _currentEnemy > 0)  exitWith{objNull}; 
if!(_currentEnemy isKindOf "land")		  exitWith{objNull};
if((count crew _currentEnemy)<1)		  exitWith{objNull};
if(_currentEnemy == _lastKnownEnemy)	  exitWith{objNull};
if(_currentEnemy distance2D _leader > 600)exitWith{objNull};

 [_group, "lastSpotting", time] call SFSM_fnc_groupData;

"Enemy spotted" call SFSM_fnc_debugMessage;

_currentEnemy;