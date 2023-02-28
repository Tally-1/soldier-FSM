params ["_man", "_target"];

if(isNil "_target")			                         exitWith{};
if(isNil "_man")			                         exitWith{};
if!(_target isKindOf "man")	                         exitWith{};
if!(_man isKindOf "man")	                         exitWith{};
if(_man distance2D _target > 400)                    exitWith{};
if(_man getVariable ["ace_isunconscious", false])    exitWith{};
if(_target getVariable ["ace_isunconscious", false]) exitWith{};
if(!alive _target)                                   exitWith{};

private _knowledge		    = _man knowsAbout _target;
private _targetVerified	    = _knowledge == 4;
private _interSectObjTorso	= lineIntersectsWith [(eyePos _man), (aimPos _target), _man, _target, false];
private _interSectObjHead	= lineIntersectsWith [(eyePos _man), (eyePos _target), _man, _target, false];

private _hasLineOfSight		= (_interSectObjTorso isEqualTo [] 
							or _interSectObjHead  isEqualTo []);


if(_targetVerified
&&{_hasLineOfSight})exitWith{[_man, _target] call SFSM_fnc_directReactFire};

/***************************************************************/

//30% chance of shooting anyway if enemy cannot be seen.
private _shootAnyway = (random 1)>0.7; 
if!(_shootAnyway)exitWith{};

//Shoot in the middle of enemy group 
private _targetPos = ([_target, 50] call Tcore_fnc_clusterPos);
if(isNil "_targetPos")then{_targetPos = getPos _target};

_targetPos = AGLToASL _targetPos;

[_man, "action", "return fire"]	call SFSM_fnc_unitData;
_man doSuppressiveFire _targetPos;
waitUntil {sleep 0.1; !(currentCommand _man == "Suppress")};



//finalize return-fire
[_man] call SFSM_fnc_endReactiveFire;