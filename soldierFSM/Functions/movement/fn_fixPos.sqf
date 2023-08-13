// This function deletes the "intended" position of the man, and 
// stops the engine from forcing unwanted movement.
params["_man"];
private _asl = getPosASLVisual _man;
private _atl = getPosATLVisual _man;

_man setPos (getPos _man);

_man setPosASL _asl;
_man setPosATL _atl;

// _man moveTo (getPos _man);
_man doMove _atl;//(getPos _man);
// _man setPos (getPos _man);
getPos _man;

true;