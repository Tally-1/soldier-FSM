if!(SFSM_noRubber)exitWith{};

["sprint_end", {
params["_man", "_destination"];

private _obj = createSimpleObject ["Land_HelipadEmpty_F", (getPosASLVisual _man), true];
_obj setdir (getDir _man);
_man attachTo [_obj, [0,0,0]];
_man setDir 0;

[_man, _obj]spawn{
    params["_man", "_obj"];
    sleep 0.02;
    detach _man;
    _man setPosASL (getPosASLVisual _obj);
    deleteVehicle _obj;
    [_man] call SFSM_fnc_fixPos;
};

}] call CBA_fnc_addEventHandler;