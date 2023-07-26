private _keepers = [];
params["_fipo", "_keepers"];
private _unwanted = (synchronizedObjects _fipo) select {!(_x in _keepers)};
_fipo synchronizeObjectsRemove _unwanted;
true;