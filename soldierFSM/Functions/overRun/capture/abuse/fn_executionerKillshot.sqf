params["_executioner", "_victim"];
private _anchor = _executioner getVariable ["SFSM_myAnchor", objNull];
private _pos    = getPosASLVisual _victim;
private _eh     = [_executioner] call SFSM_fnc_executionerKillshotEh;
private _pistol = (handgunWeapon _executioner);

_executioner selectWeapon _pistol;
_executioner attachTo [_victim, [0,0,0]];
_executioner switchMove "Acts_Executioner_Kill";

if(!isNull _anchor)then{deleteVehicle _anchor;};

_anchor = createSimpleObject ["UserTexture1m_F", _pos, false];
_anchor attachTo [_victim, [0,0,0]];

_executioner setVariable ["SFSM_myAnchor", _anchor];
_executioner disableAI "MOVE";

sleep 0.1; 
detach _executioner;
detach _anchor;
sleep 0.9;
_victim switchMove "acts_executionvictim_kill";
sleep 0.6;

_executioner selectWeapon _pistol;

[_executioner, 1, true] call SFSM_fnc_forcedFire;

_executioner attachTo [_anchor, [0,0,0]];
_victim      attachTo [_anchor, [0,0,0]];

[_executioner, 4, true] call SFSM_fnc_forcedFire;

detach _executioner;
detach _victim;

sleep 0.1;
[_executioner, 1, true] call SFSM_fnc_forcedFire;
sleep 0.1;
[_executioner, 1, true] call SFSM_fnc_forcedFire;

deleteVehicle _anchor;

_executioner removeEventHandler ["Fired", _eh];

_executioner enableAI "MOVE";

_executioner selectWeapon (primaryWeapon _executioner);

if(alive _victim
&&{([_executioner] call SFSM_fnc_isPlayer) isEqualTo false})then{ 
	_victim playMoveNow "Acts_executionvictim_Loop";
	sleep 2;
	_executioner doFire _victim;
};

true;