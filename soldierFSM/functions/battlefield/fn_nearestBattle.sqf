params["_position"];
if(count SFSM_battles < 1)exitWith{objNull};

private _battlePositions = [];
{
	private _battlePosition = _y get "center";
	_battlePositions pushBackUnique _battlePosition;
} forEach SFSM_battles;

private _nearestPos = [_position, _battlePositions] call Tcore_fnc_nearestPos;


_nearestBattle = SFSM_battles get (str _nearestPos);

if(isNil "_nearestBattle")exitWith{objNull};

_nearestBattle