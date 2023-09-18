TMOD_fnc_initTraits = { 
params["_module"];

[] spawn{
    sleep 3;
    systemChat "hello there...";
};

[_module] call SFSM_fnc_initTraitsModule;
};