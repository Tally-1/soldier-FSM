// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _camPos = (positionCameraToWorld [0,0,0]);
private _men    = _camPos nearEntities  ["CAManBase", 200];

{
    private _notPlayer = (_x isNotEqualTo player);
    if(_notPlayer
    &&{(_x Getvariable ["bis_fnc_moduleRemoteControl_owner", ""]) isEqualTo ""})
    then{[_x] call SFSM_fnc_3DdebugText;};
} forEach _men;