params["_dragger", "_draggedMan"];
_draggedMan disableAI "anim";
_draggedMan switchMove "AinjPpneMrunSnonWnonDb_still";
sleep 0.1;
_dragger switchMove "ace_dragging_static";
sleep 0.1;
_dragger attachTo [_draggedMan, [0,1.2,0], "face", true];
_dragger setDir 180;

true; 