params ["_man", "_positions"];

private _counter  = 1; 
_positions = _positions select {(_man distance2D _x)<300};
private _posCount = count _positions;

if(_posCount == 0)exitWith{};
if(_man getVariable ["ace_isunconscious", false])exitWith{};

// change the format of all positions to ASL for visibility-check and supression-command.
private _ASL_positions = [];
{_ASL_positions pushBackUnique (AGLToASL _x)}forEach _positions;



// sort positions by distance.
_ASL_positions = [_man, _ASL_positions] call Tcore_fnc_sortByDist;

{
	if(_man getVariable ["ace_isunconscious", false])exitWith{};
	if(!alive _man)exitWith{};

	private _movePos = [_man, _x] call SFSM_fnc_findFirePos;
	private _manPos  = _man call Tcore_fnc_getPos;

	//make sure there are enemies left near the target-position.
	private _enemiesOnPos = [_man, 20, true, (ASLToAGL _x)] call Tcore_fnc_nearSoldiers;
	private _doFire = (count _enemiesOnPos > 0);
	if(_doFire)then{

	//move to fire-pos if needed
	if((!(_movePos isEqualTo _manPos))
	&&{!(_movePos isEqualTo [0,0,0])})
	then{
			private _move = [_man, _movePos, _x] spawn SFSM_fnc_moveToFirePos;
			[_man, "action", "Moving to fire-position"] call SFSM_fnc_unitData;
			waitUntil{sleep 1; scriptDone _move;};
			[_man, "action", "none"] call SFSM_fnc_unitData;
	};

	//suppress position
	private _supText = ["Suppressing position ", _counter, " of ", _posCount, "!"] joinString "";
	private _timer = time + 30;
	[_man, "action", _supText] call SFSM_fnc_unitData;
	_man doSuppressiveFire _x;

	waitUntil {sleep 0.1; ((!(currentCommand _man == "Suppress")) or time > _timer);};

	if(!alive _man)exitWith{};
	if(_man getVariable ["ace_isunconscious", false])exitWith{};

	// reload
	private _reloadNeeded = needReload _man > 0.9;
	if(_reloadNeeded)then{[_man, "action", "reloading!"] call SFSM_fnc_unitData; reload _man; sleep 7;};

	
	};
	_counter = _counter+1;
} forEach _ASL_positions;

[_man, "action", "none"] call SFSM_fnc_unitData;
true;