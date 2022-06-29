private _maxTime = 30;
params ["_man", "_pos", "_maxTime"];



private _timer = time + _maxTime;
private _distance = round(_man distance2d _pos);

_man disableAI "TARGET";
_man disableAI "AUTOCOMBAT";
_man disableAI "AUTOTARGET";
_man disableAI "TARGET";
_man disableAI "FSM";
_man disableAI "CHECKVISIBLE";

_man moveTo _pos;
_man doMove _pos;
_man doTarget objNull;


while {sleep 1; _distance > 1.1} do {
	

	private _hasMovedCloser = _distance > ((eyePos _man) distance2d _pos);
	_distance = ((eyePos _man) distance2d _pos);

	if!(_hasMovedCloser)
	then{
			_man moveTo _pos;
			_man doMove _pos;
			_man doTarget objNull;
		};
	
	if(_distance < 1.1) exitWith{};
	if(time > _Timer)exitWith{};
	if(!alive _man)exitWith{};

	

	
	// 
};

_man enableAI "TARGET";
_man enableAI "AUTOCOMBAT";
_man enableAI "AUTOTARGET";
_man enableAI "TARGET";
_man enableAI "FSM";
_man enableAI "CHECKVISIBLE";

true;