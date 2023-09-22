params["_man", "_enemies"];
if(_enemies isEqualTo [])exitWith{false;};

private _inFipo = [_man, true] call SFSM_fnc_inFipo;

// Special conditions apply to units in FIPOs
if(_inFipo isEqualTo true)    
exitWith{[_man, _enemies] call SFSM_fnc_canBeOverrunFipo;};


// Not in fipo and not available
if([_man] call SFSM_fnc_availableAiSoldier isEqualTo false) 
exitWith{false;};


private _house = [_man] call SFSM_fnc_currentBuilding;

if(isNil "_house" isEqualTo false)then{
	[["Unit is indoors"], 2] call dbgmsg;
	_enemies = _enemies select {
		_x distance2D _man < (SFSM_overRunDistance*0.5);
	};
};

if(_enemies isEqualTo [])exitWith{
	"indoor unit not yet overrun" call dbgmsg;
	false;
};

true;