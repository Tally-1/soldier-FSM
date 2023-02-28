private _maxTime = 30;
private _maxDistance = 1.1;
private _spamTimer = 0.5;
params [
	"_man",            // the man that will move.
	"_pos",           //  target position
	"_maxTime",      //   timeout (max time to attempt to reach said pos)
	"_maxDistance", //    distance to wanted pos before aborting move.
	"_spamTimer"   //     how often the doMove command is repeated.
	];

private _canSprint = [_man, _pos, 50, 10] call SFSM_fnc_canSprint;

if(_canSprint)exitWith{
	private _sprint = [_man, _pos] spawn SFSM_fnc_sprint;
	waitUntil{sleep 0.3; scriptDone _sprint;};
	
	//repeated twice here because sometimes the sprint does not reach all the way.
	_canSprint = [_man, _pos, 30, 10] call SFSM_fnc_canSprint;
	if(_canSprint)then{
	private _sprint = [_man, _pos] spawn SFSM_fnc_sprint;
	waitUntil{sleep 0.3; scriptDone _sprint;};
	}
};

private _timer = time + _maxTime;
private _distance = round(_man distance2d _pos);

if(SFSM_forceDodge)
then{[_man, false] call Tcore_fnc_toggleAiMoveInhibitors};


doStop _man;
_man doMove _pos;
_man doTarget objNull;
_man disableAI "FSM";

while {sleep _spamTimer; _distance > _maxDistance} do {
	

	private _hasMovedCloser = _distance > ((eyePos _man) distance2d _pos);
	private _canSprint = false;
	_distance = ((eyePos _man) distance2d _pos);

	if!(_hasMovedCloser)
	then{
			_canSprint = [_man, _pos, 50, 20] call SFSM_fnc_canSprint;
			_man setDestination [_pos, "DoNotPlanFormation", true];
			_man doMove _pos;
			_man moveTo _pos;
			_man doTarget objNull;
			_man disableAI "AUTOTARGET";
			_man setCombatBehaviour "AWARE";
		};
	
	if(_canSprint)then{
		private _sprint = [_man, _pos] spawn SFSM_fnc_sprint;
		waitUntil{sleep 0.1; scriptDone _sprint;};
	};

	if(_distance < _maxDistance)                     exitWith{false};
	if(time > _Timer)	                             exitWith{false};
	if(!alive _man)		                             exitWith{false};
	if(_man getVariable ["ace_isunconscious", false])exitWith{false;};

};
_man enableAI "AUTOTARGET";
_man enableAI "FSM";

if(SFSM_forceDodge)
then{[_man, true] call Tcore_fnc_toggleAiMoveInhibitors};

private _currentPos = (getPos _man);
_man moveTo _currentPos;
_man doMove _currentPos;
_man doTarget objNull;
_man doFollow (leader (group _man));
true;