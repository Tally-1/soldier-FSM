private _nearEnemies = [];
params[
	"_man", // the man who will shoot.
	"_movePos", // where he will shoot from 
	"_targetPos"// the position he will shoot at.
	];

_movePos = [_movePos#0,_movePos#1,0];
private _timer = time + SFSM_DodgeTimer;
private _distance = round(_man distance2d _movePos);


if(SFSM_forceDodge)
then{[_man, false] call Tcore_fnc_toggleAiMoveInhibitors};


_man setAnimSpeedCoef SFSM_sprintSpeed;

_man doMove (getPos _man);
_man doMove _movePos;
_man doTarget objNull;


while {sleep 2; _distance > 3} do {
	
	private _killEnemies = [_man, 150] spawn SFSM_fnc_killNearEnemies; 
	waitUntil {sleep 0.5; scriptDone _killEnemies;};

	private _visible = ([(aimPos _man), _targetPos] call Tcore_fnc_visibility) > 0.8;
    private _hasMovedCloser = _distance > ((aimPos _man) distance2d _movePos);
	_distance = ((aimPos _man) distance2d _movePos);

	if!(_hasMovedCloser)
	then{
			_man doMove _movePos;
			_man doTarget objNull;
		};
	

	if(_distance < 3)                                 exitWith{false};
	if(time > _Timer)	                              exitWith{false};
	if(!alive _man)		                              exitWith{false};
	if(_visible)                                      exitWith{false};
	if(_man getVariable ["ace_isunconscious", false]) exitWith{false};
	if(_man getVariable ["dam_ignore_injured0",false])exitWith{false;};


};

if(SFSM_forceDodge)
then{[_man, true] call Tcore_fnc_toggleAiMoveInhibitors};

_man setAnimSpeedCoef 1;


_man doMove (ASLToAGL getPosASL _man);
_man doFollow (leader (group _man));

true;