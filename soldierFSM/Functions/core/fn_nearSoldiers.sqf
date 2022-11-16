//just a small filtered version of the nearEntities command, 
//excludes players, vehicles and the unit itself.
private _enemiesOnly = false;
params["_man", "_radius", "_enemiesOnly"];
private _nearSoldiers = [];
private _nearMen = _man nearEntities ["CAManBase", _radius];
		
		{
			private _isPlayer = [_x] call Tcore_fnc_isPlayer;
			private _isThisUnit = (_x == _man);
			private _valid = [_x] call SFSM_fnc_isRealMan;
			private _include = ((! _enemiesOnly) || ((side _x) != (side _man)));
			if((! _isPlayer)
			&&{(! _isThisUnit)
			&&{_valid
			&&{_include}}})
			then{_nearSoldiers pushBack _x};
			
		} forEach _nearMen;


_nearSoldiers;