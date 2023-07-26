params[
	"_maxHealCount",
	"_incapacitated", 
	"_medics",
	"_fipoMedics",
	"_regulars",
	"_specialists"
];
private _healers      = _medics;
private _woundedCount = count _incapacitated;

{
	if(count _healers isEqualTo _maxHealCount)exitWith{};
	if(count _healers     >     _woundedCount)exitWith{};
	_healers append _x;
	
} forEach [_fipoMedics, _regulars, _specialists];

_healers;