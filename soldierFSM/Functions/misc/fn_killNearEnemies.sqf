params["_man", "_radius"];

private _action = [_man, "action"] call SFSM_fnc_unitData;
//get near and visible enemies, sorted by distance.
private _enemies = [_man, (([_man, _radius, true] call Tcore_fnc_nearSoldiers) select {[_man, _x] call SFSM_fnc_targetVisible;})] call Tcore_fnc_sortByDist;
if(count _enemies > 0)
then{
		private _killTimer = time + 5;
		[_man, "action", "!Targeting Enemy!"] call SFSM_fnc_unitData;
			{
				if(side _x != side _man
				&&{side _x != sideLogic})then{
				_man doFire _x;

				waitUntil{
						sleep 0.5; 
						_man doFire _x;
						_man doMove (getPos _x);
						((!alive _x)  || 
						(!alive _man) || 
						(time > _killTimer)) 
						};
			
			} forEach _enemies;

			[_man, "action", _action] call SFSM_fnc_unitData;
		}
	};
true;