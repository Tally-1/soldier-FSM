private _isMagazine = false;
params[
    "_man", 
    "_weapon", 
    "_weaponPos", 
    "_isMagazine"
];

if(isNil "_weapon")then{_weapon = (currentWeapon _man);};
if(isNil "_weaponPos")then{_weaponPos = [(ASLToATL aimPos _man), 0.2] call Tcore_fnc_AddZ;};

private _weaponHolder = createVehicle ["WeaponHolderSimulated_Scripted", _weaponPos, [], 0, "CAN_COLLIDE"];

if!(_isMagazine)
then{
    _weaponHolder addWeaponCargo [_weapon, 1];
    _man removeWeapon _weapon;
}
else{
    _weaponHolder addMagazineCargo [_weapon, 1];
    _man removeMagazine _weapon;
};

_weaponHolder setVariable ["SFSM_deleteTime", (round time)+300];
SFSM_cleanupObjs pushBackUnique _weaponHolder;

_weaponHolder;