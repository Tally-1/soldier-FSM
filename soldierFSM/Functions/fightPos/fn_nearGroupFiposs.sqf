params["_group"];
//Leader should be still in order to avoid constant switching
private _leader = leader _group;
if(speed _leader > 5)exitwith{[]};

private _fiposs = SFSM_fipositions select {
   _x distance2D _leader < SFSM_fipoGetInDistance
   &&{[_x] call SFSM_fnc_fipoAvailable}
};

_fiposs;