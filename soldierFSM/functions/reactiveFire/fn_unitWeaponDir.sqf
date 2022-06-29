params ["_unit"];
private _vdir = _unit weaponDirection (currentWeapon _unit); 
private _adir= _vdir # 0 atan2 _vdir # 1;
_adir