// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description:

// Params:

// Return value:

// Example:

// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: ends dragging animation and drops the unit

// Return value: none

// Example: [_dragger, _draggedMan] call SFSM_fnc_endDragMan

params[
    "_dragger",   // Object - the unit that is dragging
    "_draggedMan" // Object - the unit that is being dragged
];

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