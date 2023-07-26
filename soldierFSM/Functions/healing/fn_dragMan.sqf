// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Makes one unit drag another to a position

// Return value: none 

// Example:  [_dragger, _draggedMan, _targetPos] spawn SFSM_fnc_dragUnit

params[
    "_dragger",    // Object - The unit that is dragging the wounded
    "_draggedMan", // Object - The unit that is being dragged
    "_targetPos"   // Array - The position the unit is being dragged to
];

private _grab = [_dragger, _draggedMan] spawn SFSM_fnc_initDragMan;
waitUntil { sleep 1; scriptDone _grab;};

private _drag = [_dragger, _draggedMan, _targetPos] spawn SFSM_fnc_drag;
["dragman_start", [_dragger, _draggedMan, _targetPos]] call CBA_fnc_localEvent;
waitUntil { sleep 1; scriptDone _drag;};

private _stop = [_dragger, _draggedMan] spawn SFSM_fnc_endDragMan;
["dragman_end", [_dragger, _draggedMan]] call CBA_fnc_localEvent;
waitUntil { sleep 1; scriptDone _stop;};