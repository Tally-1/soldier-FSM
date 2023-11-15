params["_executioner", "_victim"];
private _eh     = [_executioner] call SFSM_fnc_executionerKillshotEh;
private _pistol = (handgunWeapon _executioner);

_executioner selectWeapon _pistol;
_executioner attachTo [_victim, [0,0,0]];
_executioner switchMove "Acts_Executioner_Kill";

_victim setDamage 0.95;

sleep 0.1; 
detach _executioner;
sleep 1.2;

[_executioner, 4, true] call SFSM_fnc_forcedFire;

sleep 1.2;

_executioner removeEventHandler ["Fired", _eh];

_executioner selectWeapon (primaryWeapon _executioner);

true;