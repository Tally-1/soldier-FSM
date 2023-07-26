params["_projectile"];
_projectile setVariable ["SFSM_track",[]];

while {alive _projectile}do{
    (_projectile getVariable "SFSM_track")pushBack getPos _projectile;
    sleep 0.01;
};

true;