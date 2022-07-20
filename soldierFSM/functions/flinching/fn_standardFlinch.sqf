params ["_man"];
private _minReactionTime = 0.1;
private _reactionTime	 = 1;
private _timeReduction 	 = random(_man skill "spotTime");

_reactionTime = _reactionTime - _timeReduction;

if	(_reactionTime < _minReactionTime)
then{_reactionTime = _minReactionTime};

[_man, _reactionTime] spawn SFSM_fnc_execStandardFlinch;

_reactionTime;