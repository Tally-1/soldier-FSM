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



private _timer = time + _maxTime;
private _distance = round(_man distance2d _pos);

if(SFSM_forceDodge)
then{[_man, false] call Tcore_fnc_toggleAiMoveInhibitors};

_man doMove _pos;
_man doTarget objNull;


while {sleep _spamTimer; _distance > _maxDistance} do {
	

	private _hasMovedCloser = _distance > ((eyePos _man) distance2d _pos);
	_distance = ((eyePos _man) distance2d _pos);

	if!(_hasMovedCloser)
	then{
			_man doMove _pos;
			_man doTarget objNull;
		};
	
	if(_distance < _maxDistance)exitWith{false};
	if(time > _Timer)	        exitWith{false};
	if(!alive _man)		        exitWith{false};

};


if(SFSM_forceDodge)
then{[_man, true] call Tcore_fnc_toggleAiMoveInhibitors};

true;