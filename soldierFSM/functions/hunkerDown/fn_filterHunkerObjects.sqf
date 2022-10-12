params ["_side", "_battlefield", "_hunkerObjData", "_hnkObjects"];

private _enemyPositions = [_side, _battlefield] call SFSM_fnc_getEnemyPositions;

if(count _enemyPositions < 1)exitWith{[]};
if(count _hnkObjects < 1)exitWith{[]};

private _approvedKeys   = [];
private _counter = 0;
{
			private _object = _hnkObjects # _counter;
			private _shape  = _y get "3dData";
			private _topPos = (_shape get "top");
			_topPos         = [_topPos#0, _topPos#1, (_topPos#2 + 0.5)];
			private _visible = [_topPos, _enemyPositions] call Tcore_fnc_visibleFromPositions;

			if(_visible
			&&{(_y get "owner") == "none"})
			then{
					private _key    = _x;
					_approvedKeys pushBack _key;
					_y set ["available", true];	
				}
			else{_y set ["available", false]};

			_counter = _counter + 1;
} forEach _hunkerObjData;


private _approvedObjects   = [];

{
	private _pos = (ASLToAGL (getPosASLVisual _x));
	private _key = str _pos;

	if(_key in _approvedKeys)
	then{_approvedObjects pushBackUnique _x};

} forEach _hnkObjects;

_approvedObjects