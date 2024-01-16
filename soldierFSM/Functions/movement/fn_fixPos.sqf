// This function deletes the "intended" position of the man, and 
// stops the engine from forcing unwanted movement.
// When called from the resetBrain (_liftMan param) function the unit is also lifted slightly
// as that sometimes helps dislodge frozen units

params[
	["_man",     nil, [objNull]],
	["_liftMan", false, [false]]
];

if!([_man, true] call SFSM_fnc_canRun)exitWith{};

private _pos     = getPos _man;
private _asl     = getPosASLVisual _man;
private _atl     = getPosATLVisual _man;
private _atlPlus = [_atl, 0.25] call Tcore_fnc_addZ;

_man setPos _pos;
_man setPosASL _asl;

if(_liftMan)
then{_man setPosATL _atlPlus;}
else{_man setPosATL _atl;};

// This move-order is intended to delete any other "intentions" the unit may have.
_man doMove _atl;

getPos _man;

true;