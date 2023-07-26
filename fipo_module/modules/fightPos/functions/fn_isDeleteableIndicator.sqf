params["_object", "_excluded"];
if(_object in _excluded)exitWith{false;};

private _type = toLowerANSI typeOf _object;
if!("soldier_vr_f" in _type)exitWith{false;};

private _init        = toLowerANSI ((_x get3DENAttribute "Init")#0);
private _correctInit = toLowerANSI "this setVariable ['fipo_ind', true]; deleteVehicle this;";
if(_init isNotEqualTo _correctInit)exitWith{false;};

true;