params["_dragger", "_draggedMan"];
_dragger switchMove "ace_dragging_static";
_draggedMan switchMove "AinjPpneMrunSnonWnonDb_still";

_dragger addEventHandler ["AnimDone", {
	params ["_unit", "_anim"];
	if("ace_dragging_drop" == _anim)then{
		_unit removeEventHandler [_thisEvent, _thisEventHandler]; 
		_unit setVariable ["SFSM_dragDone", true];
		detach _unit;
	};
}];

private _timer = time +5;
_dragger playMoveNow "ace_dragging_drop";

waitUntil { sleep 0.1; (_dragger getVariable ["SFSM_dragDone", false] || time > _timer)};
_dragger setVariable ["SFSM_dragDone", nil];

_draggedMan switchMove "AinjPpneMstpSnonWrflDb_release";

_draggedMan enableAI "anim";
[[(name _dragger)," released ", (name _draggedMan),"."], 1] call dbgmsg;

true;