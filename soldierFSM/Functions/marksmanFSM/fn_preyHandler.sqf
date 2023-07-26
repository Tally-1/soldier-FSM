params ["_target"];
private _eh =
_target addEventHandler ["HitPart", {
    (_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
    
    private _track = _projectile getVariable "SFSM_track";
    if(isNil "_track")exitWith{};
    private _bPos = (getPos _projectile);
    private _hitPos = ASLToAGL _position;
    private _final = ([[_bPos, _hitPos], [], {_shooter distance _x }, "ASCEND"] call BIS_fnc_sortBy)#1;
    _track pushBack _final;


    SFSM_trajectories pushBack [_track];//_trajectory;

    []spawn{
        sleep 300;
        SFSM_trajectories deleteAt 0;
    };
}];

_eh;