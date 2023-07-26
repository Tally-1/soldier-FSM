//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3


params["_man", "_success", "_weapon", "_exitYa"];
private _statusText = "failed picking up weapon";

if((!isNil "_exitYa")&&{_exitYa})exitWith{
    [_man, "action", "none"] call SFSM_fnc_unitData;
    if((!isNil "_weapon")
    &&{!isNull _weapon})
    then{_weaponObject setVariable ["SFSM_newOwner", nil]}
};

if(_success)
then{_statusText = "Picked up weapon successFully!"};

[_man, "action", _statusText] call SFSM_fnc_unitData;
_man setAnimSpeedCoef 1;
sleep 1;
[_man, "action", "none"] call SFSM_fnc_unitData;
[_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;
_man doMove (getPos _man);
_man doFollow (leader (group _man));

if((!isNil "_weapon")
&&{!isNull _weapon})
then{_weaponObject setVariable ["SFSM_newOwner", nil]}