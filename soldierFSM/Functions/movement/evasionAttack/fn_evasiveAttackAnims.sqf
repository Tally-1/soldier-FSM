params[
    ["_man",      nil, [objNull]],
    ["_target",   nil, [objNull]]
];
private _attackTypes = [];

{
    if(_y call ["clearPath", [_man, _target]])
    then{_attackTypes pushBack (_y get "name")};
    
} forEach SFSM_attackAnims;

if(_attackTypes isEqualTo [])exitWith{[]};


private _moveType = selectRandom _attackTypes;
private _animMap  = SFSM_attackAnims get _moveType;
private _anims    = _animMap get "animations";//
private _path     = (_animMap call ["getPath", [_man, _target]]) apply {[_x#0, _x#1, 1];};

[_man, _moveType] spawn SFSM_fnc_flashAction;

/*WHEN DEBUGGING THIS IS USEFULL IN ORDER TO PREVIEW CHOSEN PATH*/
//"flank right";//"zig-zag";//, "flank right", "flank left"
// SFSM_Custom3Dpositions = [];
// SFSM_trajectories      = [];

// for "_i"from 0 to (count _path-2)do
// {
//     private _pos     = _path#_i;
//     private _nextPos = _path#(_i+1);
//     private _trajectory = [[_pos, _nextPos]];
//     SFSM_Custom3Dpositions pushBack [_pos, str _i];
//     SFSM_trajectories pushBack _trajectory;
    
// };


_anims;