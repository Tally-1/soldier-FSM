private _radius = SFSM_DodgeDistance;
private _selectNearest = false;
params ["_man", '_searchPos', '_radius'];

private _battlefield = [_man] call SFSM_fnc_getBattlefield;
if(isNil "_battlefield")exitWith{};
if(isNil '_searchPos')then{_searchPos = getPos _man};


private _side           = side _man;
private _coverPositions = [];
private _cPosData       = _battleField get "coverPositions";

if(isNil '_cPosData')   exitWith{[_man, _radius] call Tcore_fnc_coverPosSimple};

switch (_side) do {
	case east: 			{ _coverPositions =  _cPosData get "east"; };
	case west: 			{ _coverPositions =  _cPosData get "west"; };
	case independent: 	{ _coverPositions =  _cPosData get "independent"; };
};

if(isNil '_coverPositions')exitWith{[_man, _radius] call Tcore_fnc_coverPosSimple};

_coverPositions = (_coverPositions inAreaArray [_searchPos, _radius, _radius]);


private _coverPos = [_man, _coverPositions, _battleField] call SFSM_fnc_selectCoverPos;

if(isNil '_coverPos')exitWith{[_man, _radius] call Tcore_fnc_coverPosSimple};

_coverPos 