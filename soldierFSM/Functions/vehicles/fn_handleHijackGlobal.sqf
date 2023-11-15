if(SFSM_hijackVehicles isEqualTo "never")exitWith{};

[] call SFSM_fnc_reinforceVehGlobal;
[] call SFSM_fnc_hijackVehiclesGlobal;

true;