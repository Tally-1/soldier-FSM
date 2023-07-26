params["_group"];
_group addEventHandler ["Fleeing", {
    params ["_group", "_fleeingNow"];

    if(_fleeingNow
    &&{!(_group getVariable ["SFSM_fled", false])})
    then{[_group] call SFSM_fnc_groupFlee;};    

}];