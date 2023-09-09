params["_man", ["_distance", 30]];
private _enemies = ([_man, _distance] call SFSM_fnc_nearEnemies)select{
        	private _dir          = getDirVisual _man;
			private _targetDir    = _man getDir _x;
			[_dir, _targetDir, 10] call SFSM_fnc_inDirRange;
};

_enemies;