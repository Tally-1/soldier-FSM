params ["_weaponType", "_supplyObject"];
private _hasWanted  = 0;
private _wantedMagTypes = compatibleMagazines [_weaponType, "this"];
{
	if(_x in _wantedMagTypes)then{
		_hasWanted  = _hasWanted+1;
	};

}forEach(magazineCargo _supplyObject);


if(_supplyObject isKindOf "man" && {!alive _supplyObject})then{
	
	{
		if(_x in _wantedMagTypes)then{
			_hasWanted  = _hasWanted+1;
		};

	}forEach(magazines _supplyObject);
};


_hasWanted;