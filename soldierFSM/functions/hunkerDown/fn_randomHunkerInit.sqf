params ["_man"];

sleep (random 15);

if(!alive _man)exitWith{};



private _weapon = ([(primaryWeapon _man)] call BIS_fnc_itemType)#1;
private _launcher = ([(secondaryWeapon _man)] call BIS_fnc_itemType)#1;
private _machineGunner = _weapon == "MachineGun";
private _medic         = "Medikit" 	in (items _man);
private _misileGuy     = _launcher == "MissileLauncher";
private _hunkerDown = (random 1 > 0.7
					or _machineGunner
					or _medic
					or _misileGuy);

if(_hunkerDown)exitWith{[_man] call SFSM_fnc_initHunker};

_man doFollow leader(group _man);