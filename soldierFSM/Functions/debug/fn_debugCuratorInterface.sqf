private _timer = time + 0.5;
waituntil {sleep 0.5; !isNull (findDisplay 312) || {time > _timer}};
if(isNull (findDisplay 312))exitWith{SFSM_AimingMen = []};


private _camPos = positionCameraToWorld [0,0,0];
private _battle = [_camPos] call SFSM_fnc_nearestBattle;
private _battleFound = typeName _battle == "hashmap";
if(_battleFound
&& {_battle get "center" distance2D _camPos < ((_battle get "radius")*2)})then{
    [["press ctrl + G to toggle 3D grid-markers on the battlefield"], 2] call dbgmsg;
};

(findDisplay 312) displayAddEventHandler ["KeyDown", "_this call SFSM_fnc_debugCuratorKeyHandler"];


true;