params["_posA", "_posB"];

private _objA = (nearestObjects [[_posA#0,_posA#1], ["Land"], 3])#0;
if(isNil "_objA")then{_objA = objNull};
private _objB = (nearestObjects [[_posB#0,_posB#1], ["Land"], 3])#0;
if(isNil "_objB")then{_objB = objNull};

private _visibility = ([_objA, "VIEW", _objB] checkVisibility [_posA, _posB]);

_visibility;