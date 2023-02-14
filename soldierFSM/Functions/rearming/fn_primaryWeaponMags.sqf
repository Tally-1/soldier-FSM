params ["_man"];
private _wantedMags = compatibleMagazines [(primaryWeapon _man), "this"];
private _magazines  = magazines _man;
private _weaponMags = _magazines select {_x in _wantedMags};

(count _weaponMags);