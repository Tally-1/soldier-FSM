params["_man", "_house"];
if!(SFSM_rpgHouse)exitWith{false;};
if(isNil "_man")exitWith{false;};
if!([_man] call SFSM_fnc_isRealMan)exitWith{ false;};
if(_man getVariable ["SFSM_excluded", false])exitWith{false;};
private _action = [_man, "action"] call SFSM_fnc_unitData;
if(isNil "_action")exitWith{false;};
if(_action != "none")exitWith{false;};
private _launcher = secondaryWeapon _man;
if(_launcher == "")exitWith{false;};

private _launcherType = ([_launcher] call objScan_fnc_weaponData) get "description";
if(_launcherType == "AA misile launcher")exitWith{false;};
if!([_man, _launcher] call SFSM_fnc_hasAmmoForWeapon)exitWith{false;};
private _launchPos = [_man, _house] call SFSM_fnc_firePosLite;
if(isNil "_launchPos")
exitWith{
        "could not find a position to launch missile at house" call dbgmsg;
		false;
	};

[_man, "currentDestination", _launchPos] call SFSM_fnc_unitData;

true;