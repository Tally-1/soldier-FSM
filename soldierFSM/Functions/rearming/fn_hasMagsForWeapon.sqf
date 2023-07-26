// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_weaponType", "_supplyObject"];
private _hasWanted  = 0;
private _wantedMagTypes = compatibleMagazines [_weaponType, "this"];
{
    if(_x in _wantedMagTypes)then{
        _hasWanted  = _hasWanted+1;
    };

}forEach(magazineCargo _supplyObject);


if(_supplyObject isKindOf "man" && {!alive _supplyObject})then{
    
    {
        if(_x in _wantedMagTypes)then{
            _hasWanted  = _hasWanted+1;
        };

    }forEach(magazines _supplyObject);
};


_hasWanted;