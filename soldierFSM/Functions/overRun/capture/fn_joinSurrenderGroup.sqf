params["_man", "_side"];
private _availableGrps = allGroups select {
    (leader _x distance2D _man < 100
    &&{side _x isEqualTo _side
    &&{_x getVariable ["SFSM_SurrenderGroup", false]}})};

private _timer  = time+1;
private _newGrp = _availableGrps#0;

if(isNil "_newGrp")then{
    _newGrp = createGroup _side;
};

[_man] joinSilent _newGrp;
_newGrp setVariable ["SFSM_SurrenderGroup", true];
while{group _man isNotEqualTo _newGrp}do{[_man] joinSilent _newGrp};

_newGrp;