params ["_man", "_grenade", "_velocity", "_source"];
private _animation = "AwopPercMstpSgthWrflDnon_End1";

if(stance _man == "CROUCH")then{_animation = "AwopPknlMstpSgthWrflDnon_End";};
if(stance _man == "PRONE") then{_animation = "AwopPpneMstpSgthWrflDnon_End";};

for "_i"from 0 to 1 do {
_man setDir (_man getDir _source);
sleep 0.02;
};


_grenade attachTo [_man, [0,0,0.1], "rwrist", true];
_man switchMove _animation;
sleep 0.3;
detach _grenade;
_grenade setPosASL eyePos _man;
_grenade setDir (getDir _man);
sleep 0.02;
_grenade setVelocityModelSpace [_velocity#0, _velocity#1, ((_velocity#2)*2)];