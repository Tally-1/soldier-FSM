params["_fipo"];
private _sides = [];
if(_fipo getVariable "alloweast")        then{_sides pushBack east;};
if(_fipo getVariable "allowindependent") then{_sides pushBack independent;};
if(_fipo getVariable "allowwest")        then{_sides pushBack west;};

if(_sides isEqualTo [])then{"Error: Fipo with no sides allowed detected" call dbgmsg;};
_fipo setVariable ["allowedSides", _sides, true];

if(count _sides isEqualTo 1)then{
	_fipo setVariable ["side", _sides#0, true];
};

_sides;