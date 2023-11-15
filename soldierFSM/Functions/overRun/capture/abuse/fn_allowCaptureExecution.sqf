params [
	"_captive", 
	"_captor",
	["_forced", false]
];
// Players have their own action for this
if([_captor] call SFSM_fnc_isPlayer) exitWith{false;};
if(_forced)                          exitWith{true;};

// check probability by CBA settings.
private _val   = random 1;
private _allow = _val < SFSM_captureExecProb;

if([_captor] call SFSM_fnc_isPlayer)then{
	_allow = _val < SFSM_cptrExecProbPlr;
};

if!(_allow)exitWith{false;};

true;