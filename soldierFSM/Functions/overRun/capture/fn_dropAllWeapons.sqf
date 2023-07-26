private _storeAsVariable = false;
params["_man", "_storeAsVariable"];
private _weapons  = [primaryWeapon _man, handgunWeapon _man, secondaryWeapon _man];
private _grenades = magazines _man select {"Grenade" in _x};
private _droppedWeapons  = [];
private _droppedGrenades = [];

for "_i" from 0 to 2 do{
    private _weapon = _weapons#_i;
    if(_weapon isNotEqualTo "")then{
        private _weaponPos  = [_man, "righthand"] call SFSM_fnc_selectionPos;
        _droppedWeapons pushBack ([_man, _weapon, _weaponPos] call SFSM_fnc_dropWeapon);
        sleep 1;
}};

// {
//     _droppedGrenades pushBack ([_man, _x,nil,true] call SFSM_fnc_dropWeapon);
//     sleep 0.2;
// } forEach _grenades;


if(_storeAsVariable)then{
    _man setVariable ["SFSM_droppedWeaponHolders", [_droppedWeapons, _droppedGrenades], true];
};

true;