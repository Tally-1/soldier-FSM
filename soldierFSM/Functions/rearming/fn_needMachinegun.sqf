// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man"];
if(isNil "_man")exitWith{false};
if!([_man] call SFSM_fnc_isRealMan)exitWith{false;};

private _assetType = [_man] call SFSM_fnc_squadAsset;

if(_assetType isNotEqualTo "regular")exitWith{false;};

private _machineGunners = 0;

{
    private _assetType = [_x] call SFSM_fnc_squadAsset;
    if(_assetType isEqualTo "machineGunner")then{
        _machineGunners = _machineGunners+1;
    };
    
    
} forEach (units group _man);

if(_machineGunners >= SFSM_maxMgs)exitWith{false;};


true;