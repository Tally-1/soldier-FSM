params["_side"];
private _sides = [];

{
    if((_side knowsAbout _x >= (_self get "knowledge"))
    || ((_self get "knowledge_base") < 0.2))
    then{_sides pushBackUnique (side _x)};
    
} forEach (_self get "units");

private _filter = {_x in [east, west, independent] 
               && {([_side, _x] call BIS_fnc_sideIsFriendly) isEqualTo false;}};
private _hostileSides = _sides select _filter;

// systemChat str [_sides, _hostileSides];

if(_hostileSides isEqualTo [])exitWith{false;};

true;