// this function retrieves a position from the grid loaded into the battlefield hashmap
// that position is roughly calculated to be hidden from a specific side, based of 
// average positioning
params["_man", "_enemyVehicle"];
private _battleKey   = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battleField = SFSM_battles get _battleKey;

if(isNil "_battleField")           exitWith {"battlefield not found" call dbgmsg};
if!(_battleField get "gridLoaded") exitWith {"grid not loaded yet" call dbgmsg};

private _gridHash  = missionNamespace getVariable (_battleField get "grid");
private _enemySide = side _enemyVehicle;
private _hiddenPositions = [];

switch (_enemySide) do {
							case west:        {_hiddenPositions = _gridHash get "hiddenFromWest"};
							case east:        {_hiddenPositions = _gridHash get "hiddenFromEast"};
							case independent: {_hiddenPositions = _gridHash get "hiddenFromGuer"};
						};

if(_hiddenPositions isEqualTo [])exitWith{"HiddenPosition-selection empty" call dbgmsg};


//If hidden positions are available make sure they are not in the direction of the enemy.

private _finalSelection = [];
private _manPos         = getPos _man;
private _enemyPos       = getPos _enemyVehicle;
private _escapeDir      = _enemyPos getDir _manPos;
private _maxDeviation   = 75;

{
	private _dirToPos      = _manPos getDir _X;
	private _inEscapeRange = [_dirToPos, _escapeDir, _maxDeviation] call Tcore_fnc_inDirRange;

	if(_inEscapeRange)
	then{_finalSelection pushBack _x};
} forEach _hiddenPositions;



if(_finalSelection isEqualTo [])exitWith{"final selection empty" call dbgmsg};

private _targetPosition = selectRandom _finalSelection;

_targetPosition;