params["_man"];
private _squadMembers = units group _man;
private _ATs          = 0;

{
    private _assetType = [_x] call SFSM_fnc_squadAsset;
    
    if(_assetType isEqualTo "machineGunner")then{_ATs = _ATs+1};
    
} forEach _squadMembers;

if(_ATs >= SFSM_maxAts)exitWith{false};

true;