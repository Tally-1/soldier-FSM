// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man"];
private _wantedMags = compatibleMagazines [(primaryWeapon _man), "this"];
private _magazines  = magazines _man;
private _weaponMags = _magazines select {_x in _wantedMags};

(count _weaponMags);