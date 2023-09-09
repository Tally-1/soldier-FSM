params["_man"];
private _eh = _man addEventHandler ["AnimDone", {
	params ["_man", "_anim"];
	private _end = _this call SFSM_fnc_onAnimListEhFired;

	if(_end)then{
		_this call SFSM_fnc_animListEnd;
		_man removeEventHandler ["AnimDone", _thisEventHandler];
	};

}];

_eh;