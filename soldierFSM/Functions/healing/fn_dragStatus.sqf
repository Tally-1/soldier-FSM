params["_dragger", "_draggedMan", "_startPos", "_targetPos", "_timer"];

if(!alive _dragger)exitWith{"dragger died" call dbgmsg; true;};
if(!alive _draggedMan)exitWith{"wounded died" call dbgmsg; true;};

private _unconscious  = _dragger getVariable ["ace_isunconscious", false];
if(_unconscious)exitWith{"Dragger knocked out" call dbgmsg; true;};

if(_dragger getVariable ["dam_ignore_injured0",false])exitWith{"Dragger injured." call dbgmsg; true;};

private _conscious  = !(_draggedMan getVariable ["ace_isunconscious", false]);
if(_conscious)exitWith{"Wounded woke up" call dbgmsg; true;};

private _timedOut = time > _timer;
if(_timedOut)exitWith{
	[["Timed out, man was dragged ", (_startPos distance2D _draggedMan),"m"],2] call dbgmsg; 
	true;
};

private _arrived = _targetPos distance2D (getPosASLVisual _dragger) <= 1;
if(_arrived)exitWith{"Arrived at dragPos" call dbgmsg; true;};

private _objsInPath = [_dragger, 180, 1] call SFSM_fnc_objectsInPath;
private _object     = _objsInPath#0;
private _type       = "";
private _collide    = false;

if(!isNil "_object")then{
	private _objData =  [_object] call SFSM_fnc_terrainObjData;
	private _type    = (_objData get "type");
	_collide         = !(_type in SFSM_treeTypes);
};

if(_collide)exitWith{[["collided with ", _object]] call dbgmsg; true;};

private _menOnDestination = (_targetPos nearEntities ["CAManBase", 7])select {alive _x};
if(count _menOnDestination > 2)exitWith{"Stopped dragging, destination became crowded" call dbgmsg; true;};

false;