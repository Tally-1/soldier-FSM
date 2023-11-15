params["_man", "_side"];
if(_man in allPlayers)exitWith{grpNull};

private _group = group _man;
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
_man setVariable    ["SFSM_OriginalGroup", _group];

while{group _man isNotEqualTo _newGrp}do{[_man] joinSilent _newGrp};

_newGrp;