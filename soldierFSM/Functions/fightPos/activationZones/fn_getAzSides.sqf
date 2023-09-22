params["_activationZone"];
private _sides = [];

if(_activationZone getVariable "activatedByEast")        then{_sides pushBack east;};
if(_activationZone getVariable "activatedByIndependent") then{_sides pushBack independent;};
if(_activationZone getVariable "activatedByWest")        then{_sides pushBack west;};

if(_sides isEqualTo [])then{[["Error: ActivationZone with no sides allowed detected"],2] call dbgmsg;};

_sides;