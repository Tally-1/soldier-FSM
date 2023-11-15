params ["_caller", "_target"];
if(_caller != _target)     exitWith {false};
if(_target != player)      exitWith {false};
if(!alive _caller)         exitWith {false};

private _group  = group _caller;
private _leader = leader _group;
if(_caller != _leader) exitWith {false};

private _aiCount = count (units _group select {!(_x in allPlayers)});
if(_aiCount < 1)       exitWith {false};

true;