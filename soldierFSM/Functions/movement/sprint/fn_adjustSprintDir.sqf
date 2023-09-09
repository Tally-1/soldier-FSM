params["_man"];
private _destination    = _man getVariable "SFSM_SprintDestination";
private _wantedDir      = _man getDir _destination;
private _dirRange       = 5;
private _distance       = _man distance _destination;

if(_distance < 10)then{_dirRange = 2};

private _needsAdjusting = !([(getDir _man), _wantedDir,5] call SFSM_fnc_inDirRange);

if(_needsAdjusting) then{_man setDir _wantedDir};

true;