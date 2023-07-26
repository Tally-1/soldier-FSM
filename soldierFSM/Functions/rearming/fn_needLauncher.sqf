params["_man"];
private _squadMembers = units group _man;
private _ATs          = 0;

{
    private _assetType = [_x] call SFSM_fnc_squadAsset;
    
    if(_assetType isEqualTo "machineGunner")then{_ATs = _ATs+1;};
    if(_ATs isEqualTo 2)exitwith{};
    
} forEach _squadMembers;

if(_ATs >= 2)exitWith{false;};

true;