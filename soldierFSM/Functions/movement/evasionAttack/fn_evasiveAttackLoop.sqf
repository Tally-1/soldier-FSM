sleep 0.5;
params["_man", "_target"];
private _animPlaying = [_man, "playingAnimList"] call SFSM_fnc_unitData;
while{sleep 0.05; _animPlaying}do{

    _animPlaying = [_man, "playingAnimList"] call SFSM_fnc_unitData;
    if(_animPlaying isEqualTo false)exitWith{};
    
    [_man, _target, nil, 0.2] call SFSM_fnc_ifAimThenFire;
};

true;