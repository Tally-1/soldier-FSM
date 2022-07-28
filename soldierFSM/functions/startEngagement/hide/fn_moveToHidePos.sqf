params["_man", "_hidePos", "_enemyVehicle"];

private _timer = time + SFSM_DodgeTimer;
private _distance = round(_man distance2d _hidePos);

if(SFSM_forceDodge)
then{[_man, false] call Tcore_fnc_toggleAiMoveInhibitors};


_man setAnimSpeedCoef SFSM_sprintSpeed;
[_man, "action", "Hiding from enemy vehicle"] call SFSM_fnc_unitData;

_man doMove _hidePos;
_man doTarget objNull;



while {sleep 2; _distance > 1.1} do {
	
	private _manPos          = eyePos _man;
	private _enemyPos        = eyePos _enemyVehicle;
	private _hasMovedCloser  = _distance > (_manPos distance2d _hidePos);
	private _visibleToThreat = ([_man, "VIEW", _enemyVehicle] checkVisibility [_manPos, _enemyPos]) > 0.1;
	private _destroyed       = [_enemyVehicle]call Tcore_fnc_deadCrew;

	_distance = ((eyePos _man) distance2d _hidePos);

	if!(_hasMovedCloser)
	then{
			_man doMove _hidePos;
			_man doTarget objNull;
		};
	

	if(_distance < 1.1)  exitWith{false};
	if(time > _Timer)	 exitWith{false};
	if(!alive _man)		 exitWith{false};
	if!(_visibleToThreat)exitWith{false};
	if(_destroyed)	     exitWith{false};


};

if(SFSM_forceDodge)
then{[_man, true] call Tcore_fnc_toggleAiMoveInhibitors};

_man setAnimSpeedCoef 1;
[_man, "action", "none"] call SFSM_fnc_unitData;


private _group = group _man;
private _leader = leader _group;
private _manPos = getPos _man;

_man doFollow _leader;
_man doMove   _manPos;

true;