params [
	"_captive", 
	"_captor",
	["_forced", false]
];
if([_captor] call SFSM_fnc_isPlayer) exitWith{false;};
if(_forced)                          exitWith{true;};

// check probability by CBA settings.
private _val   = random 1;
private _allow = _val < SFSM_captureAbuseProb;

if([_captor] call SFSM_fnc_isPlayer)then{
	_allow = _val < SFSM_cptrAbuseProbPlr;
};

if!(_allow)exitWith{false;};

// Units under recent fire will not abuse prisoners.
private _lastBullet = [_captor, "Last_Close_Bullet"] call SFSM_fnc_unitData;
private _timeSince  = time - _lastBullet;

if(_timeSince < 30)exitWith{false;};

true;