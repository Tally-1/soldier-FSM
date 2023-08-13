params["_man", "_factors"]; 
_factors 
params [
	"_sum", 
	"_courageFactor", 
	"_commandFactor", 
	"_allyFactor", 
	"_enemyFactor", 
	"_suppression",
	"_damage"
];
private _moraleData = [_man, "baseMoraleFactors"] call SFSM_fnc_unitData;

_moraleData set ["courageFactor", _courageFactor];
_moraleData set ["commandFactor", _commandFactor];
_moraleData set ["allyFactor",    _allyFactor];
_moraleData set ["enemyFactor",   _enemyFactor];
_moraleData set ["suppression",   _suppression];
_moraleData set ["damage",        _damage];
_moraleData set ["sum",           _sum];

[_man, "baseMoraleFactors", _moraleData] call SFSM_fnc_unitData;

true;