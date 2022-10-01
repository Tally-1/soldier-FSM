params ["_man"];
if(isNil "_man")exitWith{false};
if!(alive _man)exitWith{false};
if!(_man isKindOf "man")exitWith{false};

private _group = group _man;
if(isNil "_group")exitWith{false};
if(isNull _group)exitWith{false};

true;