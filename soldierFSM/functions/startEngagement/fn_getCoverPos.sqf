private _radius = SFSM_DodgeDistance;
private _selectNearest = false;
params ["_man", '_searchPos', '_radius'/*, '_selectNearest'*/];

private _battlefield = [_man] call SFSM_fnc_getBattlefield;
if(isNil "_battlefield")exitWith{};
if(isNil '_searchPos')then{_searchPos = getPos _man};


private _side           = side _man;
private _coverPositions = [];
private _cPosData       = _battleField get "coverPositions";
private _manPos         = getpos _man;

if(isNil '_cPosData')   exitWith{"no positions found"};

switch (_side) do {
	case east: 			{ _coverPositions =  _cPosData get "east"; };
	case west: 			{ _coverPositions =  _cPosData get "west"; };
	case independent: 	{ _coverPositions =  _cPosData get "independent"; };
};

if(isNil '_coverPositions')   exitWith{"no positions found"};

_coverPositions = (_coverPositions inAreaArray [_searchPos, _radius, _radius]);

if(count _coverPositions == 0)exitwith{"no positions found"};

private _coverPos = [_man, _coverPositions, _battleField] call SFSM_fnc_selectCoverPos;
if(isNil '_coverPos')then{_coverPos = selectRandom _coverPositions};
if(isNil '_coverPos')exitWith{[_man] call Tcore_fnc_coverPosSimple};

// if(_selectNearest)
// then{_coverPos = [_man, _coverPositions] call Tcore_fnc_nearestPos};

_coverPos 