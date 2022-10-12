params ["_man", "_maxTime"];
private _action = [_man, "action"] call SFSM_fnc_unitData;
private _enemies = [_man, 8, true] call Tcore_fnc_nearSoldiers;

if(count _enemies > 0)
then{
      _enemies = _enemies select {
                                  (([_man, _x] call SFSM_fnc_targetVisible)
                                  &&
                                  {!([(side _man), (side _x)] call BIS_fnc_sideIsFriendly)});
                                 };
};


if(count _enemies > 0)
then{
         private _killTimer = time + (_maxTime / 2);
         [_man, "action", "CQB: !Targeting Enemy!"] call SFSM_fnc_unitData;
         _man doMove (getPos _man);

         //sort enemies according to distance.
         _enemies = [_enemies, [], {_man distance _x }, "ASCEND"] call BIS_fnc_sortBy;
         
        
        {_man doFire _x;
          waitUntil{
              sleep 0.5; 
              _man doFire _x;

              ((!alive _x)  || 
              (!alive _man) || 
              (time > _killTimer)) 
            };
          _man doMove (getPos _x);
        } forEach _enemies;
        [_man, "action", _action] call SFSM_fnc_unitData;
        _man setBehaviour "AWARE";
        _man setCombatBehaviour "AWARE";
  };

true;