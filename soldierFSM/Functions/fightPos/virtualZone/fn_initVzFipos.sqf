params[
	["_fipos", nil, [[]]]
];
_fipos call BIS_fnc_initModules;

{
	_x setvariable ["BIS_fnc_initModules_disableAutoActivation",false,true];
	[_x] call SFSM_fnc_initFipo;

	SFSM_fipositions pushBackUnique _x;
	SFSM_allFipos    pushBackUnique _x;
	
} forEach _fipos;


true;