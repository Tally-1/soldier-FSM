//just a small filtered version of the nearEntities command, 
//excludes players, vehicles and the unit itself.
params["_man", "_radius"];
private _nearSoldiers = [];
private _nearMen = _man nearEntities _radius;
		
		{
			private _isPlayer = [_x] call Tcore_fnc_isPlayer;
			private _isThisUnit = (_x == _man);
			private _valid = [_x] call SFSM_fnc_isRealMan;
			if((! _isPlayer)
			&&{(! _isThisUnit)
			&&{   _valid}})
			then{_nearSoldiers pushBack _x};
			
		} forEach _nearMen;


_nearSoldiers;