params["_player"];
if(isNil "SFSM_fnc_buddyRearm")     exitWith{false;};
if(_player call SFSM_fnc_inVehicle) exitWith{false;};
if(!isNull (findDisplay 312))       exitWith{false;};
if(insideBuilding _player > 0)      exitWith{false;};
if([_player] call SFSM_fnc_isUncon) exitWith{false;};

private _weapon       = primaryWeapon _player;
private _magCount = [_weapon, player] call SFSM_fnc_hasMagsForWeapon;
if(_magCount >= 4)exitWith{false;};

private _squadMembers = (units group _player);
if(_squadMembers isEqualTo [])exitWith{false;};

private _nearest = [_player, _squadMembers] call SFSM_fnc_getNearest;
if(_nearest distance _player > 100)exitWith{false;};

_squadMembers = _squadMembers select {[_x,_player,_weapon] call SFSM_fnc_isRearmBuddy;};
if(_squadMembers isEqualTo [])exitWith{false;};

true;