// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_dragger", "_draggedMan"];
_draggedMan disableAI "anim";
_draggedMan switchMove "AinjPpneMrunSnonWnonDb_still";
sleep 0.1;
_dragger switchMove "ace_dragging_static";
sleep 0.1;
_dragger attachTo [_draggedMan, [0,1.2,0]];
_dragger setDir 180;

true; 