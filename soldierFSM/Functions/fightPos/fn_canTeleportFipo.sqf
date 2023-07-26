params["_man", "_fipo"];
private _distance2D = (_man distance2D _fipo);
if!(SFSM_allowFipoTeleport)            exitWith{false;};
if!([_man, true] call SFSM_fnc_canRun) exitWith{false;};
if(_distance2D > 10)                   exitwith{false;};



private _canBeSpotted = false;
private _nearPlayers  = allPlayers select {_x distance2D _man < SFSM_playerSpotTeleportDist};
private _distance     = (_man distance _fipo);

if(_distance < 1)exitWith{true;};

{
    private _relDir       = (_x getRelDir _man);
    private _lookingAtMan = [0, _relDir, 45] call SFSM_fnc_inDirRange;
    private _visibility   = 0;

    // Player is looking in the direction of the Ai-soldier.
    if(_lookingAtMan)then{
        private _fightPos   = [(getPosASL _fipo), 1.4] call Tcore_fnc_AddZ;
        private _v1         = [_man, "VIEW", _x] checkVisibility [(aimPos _man), (aimPos _x)];
        private _v2         = [_man, "VIEW", _x] checkVisibility [_fightPos,     (aimPos _x)];
        
        _visibility = selectMax [_v1, _v2];
    };

    if(_visibility > 0.2)exitWith{
        _canBeSpotted = true;
    };
    
} forEach _nearPlayers;

if(_canBeSpotted)exitWith{false;};

true;