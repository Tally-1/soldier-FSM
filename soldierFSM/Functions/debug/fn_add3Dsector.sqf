params["_3Dsector"];
private _curSecId       = _3Dsector#6;
private _currentSectors = SFSM_3Dsectors select {
	private _sectorId = _x#6;
	_sectorId isEqualTo _curSecId;
};

if(_currentSectors isEqualTo [])exitWith{
	SFSM_3Dsectors pushBack _3Dsector;
};

private _prevSector = _currentSectors#0;
SFSM_3Dsectors deleteAt (SFSM_3Dsectors find _prevSector);
SFSM_3Dsectors pushBack _3Dsector;

true;