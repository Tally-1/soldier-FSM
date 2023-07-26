params ["_player"];
if(_player call SFSM_fnc_inVehicle) exitWith{false;};

private _legDamage = getAllHitPointsDamage _player#2#10;

if(damage _player < 0.75 && {_legDamage < 0.4}) exitWith{false;};
if([_player, true] call SFSM_fnc_canSelfHeal)   exitWith{false;};
    
true;