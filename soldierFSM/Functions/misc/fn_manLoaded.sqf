params["_man"];
if(isNil "_man")exitWith{false};
if(isNull _man)exitWith{false};

private _unitData = _man getVariable "SFSM_UnitData";
if(isNil "_unitData")exitWith{false};

true;