params["_distance"];
private _jog      = SFSM_moveAnims get "jog-front";
private _walk     = SFSM_moveAnims get "walk-front";
private _walkSlow = SFSM_moveAnims get "walk-front-slow";
private _animMaps = [];
private _enemies  = [_man, 30] call SFSM_fnc_enemiesInFront;

while {_distance > (_jog get "distance")
    &&{_enemies isEqualTo []}}do{
	_animMaps pushBack _jog;
	_distance = _distance - (_jog get "distance");
};

while {_distance > (_walk get "distance")}do{
	_animMaps pushBack _walk;
	_distance = _distance - (_walk get "distance");
};

while {_distance > (_walkSlow get "distance")}do{
	_animMaps pushBack _walkSlow;
	_distance = _distance - (_walkSlow get "distance");
};

_animMaps;