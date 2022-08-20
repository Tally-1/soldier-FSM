params ["_man", "_endPos"];
private _dodgeFromPos   = _endPos;
private _enemyPositions = [_man, 500, "positions"] call Tcore_fnc_nearKnownEnemies;

if(count _enemyPositions > 0)
then{
		private _newPos = [_man, _enemyPositions] call Tcore_fnc_nearestPos;
		if(typeName _newPos == "SCALAR")exitWith{}; //the nearestPos function returns a number when nothing is found
		_dodgeFromPos = _newPos;
	};


[_man, _dodgeFromPos, false] call SFSM_fnc_Dodge;

true;