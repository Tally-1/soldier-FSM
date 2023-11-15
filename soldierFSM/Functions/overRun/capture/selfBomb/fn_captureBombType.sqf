params ["_man"];
if(SFSM_captureExplosive isEqualTo "gbu")     exitWith{"Bomb_03_F";};
if(SFSM_captureExplosive isEqualTo "grenade") exitWith{"GrenadeHand";};

[_man] call SFSM_fnc_getBiggestInvExplosive;