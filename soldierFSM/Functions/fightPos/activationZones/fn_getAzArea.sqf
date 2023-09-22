params["_activationZone"]; (_activationZone getVariable "objectarea")
params["_a", "_b", "_angle", "_isRectangle", "_c"]; 
private _center = getPos _activationZone;
private _area   = [_center, _a, _b, _angle, _isRectangle, _c];

_area;