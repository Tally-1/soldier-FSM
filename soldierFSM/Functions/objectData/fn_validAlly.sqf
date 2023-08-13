params["_man", "_ally"];
if ([_man, _ally] call SFSM_fnc_validAllyVehicle)         exitWith{true;};

if!([_ally] call SFSM_fnc_functionalMan)                  exitWith{false;};
if ([_man, _ally] call SFSM_fnc_hostile)                  exitWith{false;};
if!(side _ally in [east, west, independent])              exitWith{false;};

true;