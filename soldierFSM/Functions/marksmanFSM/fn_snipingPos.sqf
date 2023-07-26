private _forcedCenter = false;
params ["_marksman", "_target", "_forcedCenter"];
private _positions     = [_marksman, _target] call SFSM_fnc_snipingPosGrid;
private _firePositions = _positions select {[_marksman, _target, _x] call SFSM_fnc_isFirePos;};
private _firePos       = [_marksman, _target, _firePositions, _forcedCenter] call SFSM_fnc_selectSnipingPos; //[_marksman, _firePositions] call SFSM_fnc_getNearest;

if(isNil "_firePos")exitWith{
    ([count _positions, " Positions selected..."] joinString "") call dbgmsg;
    ([count _firePositions, " FirePositions"] joinString "") call dbgmsg;
    "No valid firePos found" call dbgmsg;
    nil;
};

_firePos;