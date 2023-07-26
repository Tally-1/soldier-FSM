// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _includeMedics = false;
params["_group", "_includeMedics"];
private _regulars = (units _group) select {

    private _soldierType = [_x] call SFSM_fnc_squadAsset;
    
    ((_soldierType isEqualTo "regular"
    ||(_includeMedics                  && 
    {_soldierType isEqualTo "medic"})) &&
    {[_x] call SFSM_fnc_isRealMan      && 
    {[_x, true] call SFSM_fnc_canDodge
    }});

};

_regulars;