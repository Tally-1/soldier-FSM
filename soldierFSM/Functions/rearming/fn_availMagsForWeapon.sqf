private _muzzle = "this";
private _neededMags = 2;
params [
    "_man", 
    "_weapon", 
    "_neededMags", 
    "_muzzle"
];
private _ownWeapon       = primaryWeapon _man;
private _ownLauncher     = secondaryWeapon _man;
private _ownMagtypes     = compatibleMagazines [_ownWeapon,   _muzzle];
private _ownMisiletypes  = compatibleMagazines [_ownLauncher, "this"];
_ownMagtypes insert [0, _ownMisiletypes, true];

private _carriedMags   = magazineCargo _man;
private _wantedMags    = compatibleMagazines [_weapon, _muzzle];
private _availableMags = [];

{
    private _mag = _x;
    if(_mag in _wantedMags)then{
        if(_mag in _ownMagtypes && {_neededMags > 0})exitWith{_neededMags = _neededMags-1;};
        _availableMags pushBack _mag;
    };

} forEach _carriedMags;

_availableMags;