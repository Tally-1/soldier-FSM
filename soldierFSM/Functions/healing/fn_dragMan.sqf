// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Makes one unit drag another to a position

// Return value: none 

// Example:  [_dragger, _draggedMan, _targetPos] spawn SFSM_fnc_dragMan;

params[
    ["_dragger",   nil, [objNull]],  // Object - The unit that is dragging the wounded
    ["_draggedMan",nil, [objNull]], // Object  - The unit that is being dragged
    ["_targetPos", nil,      [[]]] // Array    - The position the unit is being dragged to
];

[_dragger, _draggedMan]                                call SFSM_fnc_initDragMan;
[_dragger, _draggedMan, _targetPos]                    call SFSM_fnc_drag;
["dragman_start", [_dragger, _draggedMan, _targetPos]] call CBA_fnc_localEvent;
[_dragger, _draggedMan]                                call SFSM_fnc_endDragMan;
["dragman_end", [_dragger, _draggedMan]]               call CBA_fnc_localEvent;