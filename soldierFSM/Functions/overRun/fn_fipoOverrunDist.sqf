params["_fipo"];
private _distance   = _fipo getVariable "overrundistance";
private _canOverrun = _fipo getVariable "allowOverrun";
if(_canOverrun isEqualTo false)exitWith{0;};

_distance;