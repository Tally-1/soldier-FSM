params[
    ["_man", nil],
    ["_fipo", nil],
    ["_showFireSector", false]
];

if!([_man] call SFSM_fnc_availableAiSoldier)  exitWith{false;};
if ((behaviour _man) isEqualTo "SAFE")        exitWith{false;};
if ((behaviour _man) isEqualTo "CARELESS")    exitWith{false;};

// if is leader and group has active wp
private _isLeader = (leader (group _man)) isEqualTo _man;
if (_isLeader
&& {([group _man] call SFSM_fnc_hasActiveWp)})          exitWith{false;};

// if has tried to get in within the last 60 seconds
private _timeSinceLastAttempt = time - ([_man, "lastFipoAttempt"] call SFSM_fnc_unitData);
if(_timeSinceLastAttempt < 60)exitWith{false;};

// if leader is a player, and playerFipos have been disabeled.
if(SFSM_playerSquadFipo isEqualTo false
&&{leader group _man in allPlayers})exitWith{false;};

// If enemies are near the soldier
private _enemies = [_man] call SFSM_fnc_nearEnemies;
if(_enemies isNotEqualTo [])exitWith{false;};

// if fipo is undefined then only the conditions for the man is evaluated.
if(isNil "_fipo")                                    exitWith{true;};

//if fipo is taken
if!([_fipo] call SFSM_fnc_fipoAvailable)             exitWith{false;};

//if this fipo is not allowed for this man
if!([_man, _fipo] call SFSM_fnc_fipoAllowedMan)      exitWith{false;};

// If enemies are near the fighting position
private _nearEnemies = [_man, SFSM_overRunDistance, (getPosATL _fipo)] call SFSM_fnc_nearEnemies;
if(_nearEnemies isNotEqualTo [])
exitWith{false;};

// The fighting position has been outflanked
private _flankEnemies = [_fipo, _man] call SFSM_fnc_fipoFlankEnemies;
if(_flankEnemies isNotEqualTo [[],[]])
exitWith{false;};


true;