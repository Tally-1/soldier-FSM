params [ 
    ["_man",       nil,[objNull]], // The attacker.
	["_enemy",     nil,[objNull]], // The victim.
	["_killTimer", nil,      [0]]  // Time when murder attempt ends.
];
private _valid = _enemy isKindOf "caManBase" && {[_man, _enemy] call SFSM_fnc_validEnemy};
if(_valid)then{
	_man doFire _enemy;

    waitUntil{
        sleep 1;

		private _manDown = !([_man] call SFSM_fnc_functionalMan);
		if(_manDown)exitWith{true};

		private _targetDown = !([_enemy] call SFSM_fnc_functionalMan);
		if(_targetDown)exitWith{true};

		private _timedOut = time > _killTimer;
        if(_timedOut)exitWith{true};

		_man doFire _enemy;
        _man doMove (getPos _enemy);

		false;
    };
};

true;