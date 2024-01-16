private _zombies = allUnits select {[_x] call SFSM_fnc_isBrainDead;};

if(_zombies isEqualTo [])exitWith{
    "No zombies detected" call dbgmsg; 
    [];
};

[[count _zombies, " Zombies found."]] call dbgmsg;

_zombies;