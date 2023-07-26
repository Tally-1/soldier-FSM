params["_fipo"];
private _indicators = _fipo getVariable ["indicators", []];
if(_indicators isEqualTo [])exitWith{false;};

delete3DENEntities _indicators;
_fipo setVariable ["indicators", nil];

true;