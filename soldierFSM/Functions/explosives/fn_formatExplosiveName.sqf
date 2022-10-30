params["_invName"];
private _length = count _invName;
private _cfgName = _invName select [0,(_length - 10)];
_cfgName = _cfgName insert [(count _cfgName), "F"];
_cfgName;