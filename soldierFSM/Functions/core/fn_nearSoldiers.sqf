//just a small filtered version of the nearEntities command, 
//excludes players, vehicles and the unit itself.
private _enemiesOnly = false;
params["_man", "_radius", "_enemiesOnly", "_pos"];
if(isNil "_pos")then{
	_pos = getPos _man;//ASLToAGL getPosASL _man;
	// _pos =[_pos#0, _pos#1];
	};
private _nearSoldiers = [];
private _nearMen = _pos nearEntities ["CAManBase", _radius];
		
		{
			private _isPlayer = [_x] call Tcore_fnc_isPlayer;
			private _isThisUnit = (_x == _man);
			private _valid = [_x] call SFSM_fnc_isRealMan;
			private _include = ((! _enemiesOnly) || (!([(side _man), (side _x)] call BIS_fnc_sideIsFriendly)));
			
			if((! _isPlayer)
			&&{(! _isThisUnit)
			&&{_valid
			&&{_include}}})
			then{_nearSoldiers pushBack _x};
			
		} forEach _nearMen;


_nearSoldiers;