if!(SFSM_noRubber)exitWith{};

["sprint_end", {
params["_man", "_destination"];

private _obj = createSimpleObject ["Land_HelipadEmpty_F", (getPosASLVisual _man), true];
_obj setdir (getDir _man);
_man attachTo [_obj, [0,0,0]];
_man setDir 0;

[_man, _obj]spawn{

    sleep 0.05;
    detach (_this#0);
    deleteVehicle (_this#1);

};

}] call CBA_fnc_addEventHandler;