params["_player"];
private _weapon = primaryWeapon _player;
private _squadMembers = (units group _player) select {[_x,_player,_weapon] call SFSM_fnc_isRearmBuddy;};

//Select the squadmember with the most ammo.
private _buddy = (([_squadMembers, [], {([_weapon, _x] call SFSM_fnc_hasMagsForWeapon)}, "DESCEND"] call BIS_fnc_sortBy))#0;
_buddy;