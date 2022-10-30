params ["_man"];
if(isNil "_man")exitWith{false};
if!(alive _man)exitWith{false};
if!(_man isKindOf "CAManBase")exitWith{false};
if ((_man) isKindOf "Logic")exitWith {false};
private _group = group _man;
if(isNil "_group")exitWith{false};
if(isNull _group)exitWith{false};
if(side _group == sideLogic)exitWith{false};


true;