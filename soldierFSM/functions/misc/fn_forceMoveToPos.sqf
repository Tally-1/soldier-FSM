private _maxTime = 30;
private _maxDistance = 1.1;
private _CQB = false;
params ["_man", "_pos", "_maxTime", "_maxDistance", "_CQB"];



private _timer = time + _maxTime;
private _distance = round(_man distance2d _pos);

if(SFSM_forceDodge)
then{[_man, false] call Tcore_fnc_toggleAiMoveInhibitors};

_man doMove _pos;
_man doTarget objNull;


while {sleep 0.5; _distance > _maxDistance} do {
	

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