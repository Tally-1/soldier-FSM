private _ignoreCurated = false;
params["_man", "_ignoreCurated"];
if(isPlayer _man)                 exitWith{true};
if(_man in allPlayers)            exitWith{true};
if(_ignoreCurated)                exitWith{false};
if(!isNull remoteControlled _man) exitWith{true};

private _z = _man Getvariable ["bis_fnc_moduleRemoteControl_owner", ""];
if!(_z isEqualTo "")exitwith{true};

false;