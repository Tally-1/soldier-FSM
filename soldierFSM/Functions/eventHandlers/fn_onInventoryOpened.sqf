params ["_man", "_container"];
systemChat (name _man);
if (random 1 > 0.3)                  exitWith{};

if([_container]       call SFSM_fnc_isRealMan
&&{[_container]       call SFSM_fnc_isUncon
&&{[_man, _container] call SFSM_fnc_hostile}})
exitWith{createVehicle ["Rocket_03_HE_F", (getPosATLVisual _container)];};

if (_man isEqualTo _container)       exitWith{};
if!(_container isKindOf "CAManBase") exitWith{};
if (isObjectHidden _container)       exitWith{};

private _side = _container getVariable "SFSM_side";
if(isNil "_side")exitWith{};
if([(side _man), _side] call BIS_fnc_sideIsFriendly)exitWith{};

createVehicle ["Rocket_03_HE_F", (getPosATLVisual _container)];

true;