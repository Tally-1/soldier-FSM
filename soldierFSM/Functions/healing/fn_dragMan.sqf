params["_dragger", "_draggedMan", "_targetPos"];

private _grab = [_dragger, _draggedMan] spawn SFSM_fnc_initDragMan;
waitUntil { sleep 1; scriptDone _grab;};

private _drag = [_dragger, _draggedMan, _targetPos] spawn SFSM_fnc_drag;
waitUntil { sleep 1; scriptDone _drag;};

private _stop = [_dragger, _draggedMan] spawn SFSM_fnc_endDragMan;
waitUntil { sleep 1; scriptDone _stop;};