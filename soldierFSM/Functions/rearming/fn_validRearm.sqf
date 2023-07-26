// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_supplyObject"];

if(isNil "_man")exitWith{false;};
if(isNil "_supplyObject")exitWith{false;};
if(isNull _supplyObject)exitWith{false;};
if(!alive _man)exitwith{false;};
if((_supplyObject distance2D _man) > 5)exitwith{false;};

private _hasMags = ([(primaryWeapon _man), _supplyObject] call SFSM_fnc_hasMagsForWeapon)>0;
if(! _hasMags)exitwith{false;};

true;