params ["_victim", "_killer"];
// private _text = [(name _killer), " is executing ", name _victim]joinString"";
// [_text] remoteExecCall ["systemChat", 0];
[_victim, "Being executed"] call SFSM_fnc_setAction;

private _gun  = (handgunWeapon _killer);
// private _dmg  = damage _victim;

_killer selectWeapon _gun;
_killer attachTo [_victim, [0,0,0]];
_killer switchMove "Acts_Executioner_Kill";
_victim setDamage 0.95;

sleep 0.2; 
detach _killer;
sleep 1.8;

private _weaponMode = currentWeaponMode _killer;
_killer forceWeaponFire [_gun, _weaponMode];

[_victim, "none"] call SFSM_fnc_setAction;

if(alive _victim)exitWith{};

[_victim]  remoteExecCall ["removeAllActions", 0];

["execution",  [_victim, _killer]] call CBA_fnc_localEvent;

true;