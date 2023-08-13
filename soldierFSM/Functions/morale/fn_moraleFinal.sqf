params[
    "_baseMorale", 
    "_allEvents", 
    "_storeData"
];

private _activeEvents  = [];
private _expiredEvents = [];
private _finalMorale   = _baseMorale;

{//           eventName | eventTime | morale-change | how long the effect is valid.
    _x params ["_name", "_timeStart", "_effect", "_timeLimit"];
    private _timeOut         = _timeStart + _timeLimit;
	private _timePassed      = time - _timeStart;
	private _remainingEffect = _effect * (1-(_timePassed / _timeLimit)); // If 90% of the time has passed then only 10% of the original effect is used.
            _remainingEffect = [_remainingEffect, 2] call Tcore_fnc_decimals;
    private _active          = time < _timeOut;
    
	// The morale is adjusted according to the value of recent events.
    if(_active)then{

		_activeEvents pushback [_name, round _timePassed, _remainingEffect];
		_finalMorale = _finalMorale + _remainingEffect;

	// If the data should not be stored then it is scheduled for deletion.
	}else{if(_storeData isEqualTo false)
	 then{
		_expiredEvents pushBack _x;
	}};

} forEach _allEvents;

// Delete unwanted data
{_allEvents deleteAt (_allEvents find _x);} forEach _expiredEvents;

// Make sure morale does not exceed its limits.
if(_finalMorale > 2)then{_finalMorale = 2;};
if(_finalMorale < 0)then{_finalMorale = 0;};

// For debug purposes it looks better with a number haveing max 2 decimals.
if(count (str _finalMorale) > 4)then{
 _finalMorale = [_finalMorale, 2] call Tcore_fnc_decimals;
};

[_finalMorale, _activeEvents];