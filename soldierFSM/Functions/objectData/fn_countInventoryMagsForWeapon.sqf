private _rifle = primaryWeapon (_this#0);
params[
    ["_man",     nil,   [objNull]],
    ["_weapon", _rifle,      [""]]
];
private _magTypes      = compatibleMagazines _weapon;
private _unitMags      = magazines _man;
private _primaryMags   = primaryWeaponMagazine  _man; 
private _secondaryMags = secondaryWeaponMagazine _man;
private _magCount      = 0;

_unitMags append _primaryMags;
_unitMags append _secondaryMags;

{
	if(_x in _magTypes) then{_magCount =_magCount+1;};

} forEach _unitMags;

_magCount;