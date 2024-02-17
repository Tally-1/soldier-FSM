params[
	["_man",  nil, [objNull]],
	["_fipo", nil, [objNull]]
];
if!(_fipo getVariable "twowayfipo")     exitWith{false;};
if!([_man] call SFSM_fnc_functionalMan) exitWith{false;};

private _sideMan  = side _man;
private _sideFipo = _fipo getVariable "SFSM_fipoSide";

if(isNil "_sideFipo")exitWith{
	private _msg = ["FipoSide set to ", side _man]joinString"";
	[_man, _msg] spawn SFSM_fnc_flashAction;
	_fipo setVariable ["SFSM_fipoSide", _sideMan];
	false;
};

if(_sideMan isEqualTo _sideFipo)        exitWith{false;};

true;