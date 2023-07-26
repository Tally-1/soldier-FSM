// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_group"];

private _noAutoStance = _group getVariable ["SFSM_noAutoStance", false];
if(_noAutoStance)exitWith{if(SFSM_Debugger)then{diag_log "SFSM: No auto stance"}};

private _noActionLowSuppression = true;
private _units = (units _group) select {[_x] call SFSM_fnc_isRealMan};

{
    private _action = [_x, "action"] call SFSM_fnc_unitData;

    if((getSuppression _x) < SFSM_ProneTreshHold)
    then{_noActionLowSuppression = false};
    if(_action != "none")
    then{_noActionLowSuppression = false};

} forEach _units;

if!(_noActionLowSuppression)exitWith{};

_group setCombatMode "YELLOW";

//3x spam, because ArmA, some commands do not execute for unknown reasons
{
    if!([_x]call SFSM_fnc_inFipo)then{ 
        _x setUnitPos "auto";
        _x setUnitPos "AUTO";
        _x setUnitPos "AUTO";
    };

}forEach(units _group);

true;