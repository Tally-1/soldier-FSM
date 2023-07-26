params["_man"];
private _loadOut         = _man getVariable "SFSM_loadout";
private _weaponHolders   = _man getVariable "SFSM_droppedWeaponHolders";

if(isNil "_weaponHolders"
&&{!isNil "_loadOut"})exitWith{

    _man enableAI "all";
    _man switchMove "AmovPercMstpSnonWnonDnon";
    _man setUnitLoadout _loadOut;
    _man selectWeapon primaryWeapon _man;
    _man setVariable ["SFSM_loadout", nil];
    [_man, "none"] call SFSM_fnc_setAction;
    [_man, "Back in action", 3] call SFSM_fnc_flashAction;
    [
        _man,
        "amovpercmstpsraswrfldnon",
        [
            _man, 
            false,
            {_this setCaptive false;}
        ]
    ] call SFSM_fnc_animThenExec;

};

private _droppedWeapons  = _weaponHolders#0;
private _droppedGrenades = _weaponHolders#1;

[_man]  remoteExecCall ["removeAllActions", 0];
_man setCaptive false;
_man setVariable ["SFSM_panic", false, true];
_man setVariable ["SFSM_surrendered", false, true];

if(_man in SFSM_cleanupObjs)then{SFSM_cleanupObjs deleteAt (SFSM_cleanupObjs find _man)};

[_man, "Picking up weapons"] call SFSM_fnc_setAction;

// _man playMoveNow "ApanPknlMstpSnonWnonDnon_ApanPercMstpSnonWnonDnon";
private _animHandle = ([_man, "ApanPknlMstpSnonWnonDnon_ApanPercMstpSnonWnonDnon"] call SFSM_fnc_animThenExec)#0;
//wait until animation has completed, and delete handle-variable
waitUntil{sleep 0.1; _man getVariable _animHandle};
_man setVariable [_animHandle, nil];
_man switchMove "AmovPercMstpSnonWnonDnon";

{
    private _weaponType  = getWeaponCargo _x#0#0;
    if(!isNil "_weaponType")then{
        _man action ["TakeWeapon", _x, _weaponType];
        sleep 0.5;
        private _animHandle = ([_man, "AinvPknlMstpSlayWrflDnon"] call SFSM_fnc_animThenExec)#0;
        
        if(!isNil _animHandle)then{
            waitUntil{sleep 0.1; _man getVariable _animHandle};
            _man setVariable [_animHandle, nil];
        };
        
        deleteVehicle _x;
    };
    
} forEach _droppedWeapons;

{
    private _magType  = getMagazineCargo _x#0#0;
    _man action ["TakeMagazine", _x, _magType];
    sleep 0.2;
    deleteVehicle _x;

} forEach _droppedGrenades;

_man enableAI "all";
[_man, "none"] call SFSM_fnc_setAction;
[_man, "Back in action", 3] call SFSM_fnc_flashAction;
_man selectWeapon primaryWeapon _man;
_man playMove "amovpercmstpsraswrfldnon";


_man enableAI "all";
_man setUnitLoadout _loadOut;
_man setVariable ["SFSM_loadout", nil];

true;