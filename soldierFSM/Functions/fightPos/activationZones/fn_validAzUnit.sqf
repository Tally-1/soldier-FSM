params["_entity"];

if!(_entity inArea (_self get "area"))     exitWith{false;};
if!((side _entity) in (_self get "sides")) exitWith{false;};
if!([_entity] call SFSM_fnc_functionalMan) exitWith{false;};


true;