params ["_man"];
if(isNil "_man")exitWith{false};
if!(alive _man)exitWith{false};
if!(_man isKindOf "man")exitWith{false};
if ((_man) isKindOf "Logic")exitWith {false};
private _group = group _man;
if(isNil "_group")exitWith{false};
if(isNull _group)exitWith{false};

// private _excludeVar = _man getVariable 'SFSM_excluded';
// if((!isNil '_excludeVar')
// &&{_excludeVar})exitWith{false};

true;