params["_dragger", "_draggedMan", "_targetPos"];
private _targetDir = _draggedMan getDir _targetPos;

private _woundedPos= getPosASL _draggedMan;
private _manPos    = getPosASL _dragger;

private _startPos  = _woundedPos;

private _distance  = _draggedMan distance2D _targetPos;
private _timer     = time + round(_distance*1.2);

_draggedMan setDir _targetDir;

_dragger switchMove "ace_dragging";
_draggedMan switchMove "AinjPpneMrunSnonWnonDb";
_draggedMan disableAI "anim";

waitUntil {
	sleep 0.5;
	
	// _woundedPos= getPosASL _draggedMan;
    // _manPos    = getPosASL _dragger;

	private _end = [_dragger, _draggedMan, _startPos, _targetPos, _timer] call SFSM_fnc_dragStatus;
	if(_end)exitWith{true;};

	false;
};


// _draggedMan enableAI "anim";
// _draggedMan setPosASL _woundedPos;
// _dragger    setPosASL _manPos;

true;