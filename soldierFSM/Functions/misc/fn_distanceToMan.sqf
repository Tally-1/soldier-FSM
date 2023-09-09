params["_aslPos", "_man"];
private _distance = selectMin [
	(_aslPos distance aimPos _man), 
	(_aslPos distance eyePos _man),
	(_aslPos distance getPosASLVisual _man)
];

_distance;