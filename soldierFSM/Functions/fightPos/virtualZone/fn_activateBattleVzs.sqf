params[
    ["_battlefield", nil, [createHashmap]]
];
private _radius       = _battlefield get "radius";
private _pos          = _battlefield get "center";
private _searchRadius = _radius*5;
private _activated    = 0;

if(_searchRadius > 5000)then{_searchRadius = 5000;};

{
    private _virtualZone = _x getVariable "SFSM_vzData";
    if  (_virtualZone get "activatedByBattle")
    then{
    if(_virtualZone call ["toggleZone"])
    then{_activated = _activated+1;};
    };
    
} forEach (_pos nearEntities ["SFSM_VZ", _searchRadius]);

[["Battle-start activated ",_activated, " Virtual Zones"],1] call dbgmsg;

true;