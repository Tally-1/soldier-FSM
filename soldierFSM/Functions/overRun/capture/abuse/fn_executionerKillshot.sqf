params["_executioner", "_victim"];
private _anchor = _executioner getVariable "SFSM_myAnchor";
private _eh     = [_executioner] call SFSM_fnc_executionerKillshotEh;
private _pistol = (handgunWeapon _executioner);

_executioner selectWeapon _pistol;
_executioner attachTo [_victim, [0,0,0]];
_executioner switchMove "Acts_Executioner_Kill";

if(isNil "_anchor")then{ 
    _anchor = createSimpleObject ["UserTexture1m_F", _pos, false];
	_executioner setVariable ["SFSM_myAnchor", _anchor];
};


sleep 0.1; 
detach _executioner;
sleep 0.9;
// _victim      switchMove "acts_executionvictim_kill";
_victim switchMove "Acts_executionvictim_Loop";

sleep 0.3;

_executioner selectWeapon _pistol;

_executioner attachTo [_anchor, [0,0,0]];
_victim      attachTo [_anchor, [0,0,0]];

[_executioner, 4, true] call SFSM_fnc_forcedFire;

sleep 1.2;
detach _executioner;
detach _victim;


_executioner removeEventHandler ["Fired", _eh];

_executioner selectWeapon (primaryWeapon _executioner);

true;