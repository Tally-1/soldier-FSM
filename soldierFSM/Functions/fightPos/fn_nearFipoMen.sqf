params[
	["_pos",           nil, [[]]],
	["_radius",        nil,  [0]],
	["_excludedFipos", [],  [[]]],
	["_excludedMen",   [],  [[]]]
];
private _fipos = _pos nearEntities ["SFSM_FIPO", _radius] select {!(_x in _excludedFipos);};
private _men   = (_fipos apply {[_x] call SFSM_fnc_getFipoMan})select{(!(_x in _excludedMen))&&{[_x] call SFSM_fnc_functionalMan;}};

_men;