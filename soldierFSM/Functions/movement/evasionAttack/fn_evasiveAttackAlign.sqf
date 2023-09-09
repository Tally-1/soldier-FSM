params["_man"];
private _target = _man getVariable "SFSM_myAttackTarget";

for "_i" from 1 to 3 do { 
    _man setDir (_man getDir _target);
    sleep 0.3;
};

true;