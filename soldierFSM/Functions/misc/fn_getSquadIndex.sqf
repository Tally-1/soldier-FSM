params["_man"];
private ["_vvn", "_str", "_index"];

_vvn = vehicleVarName _man;
_man setVehicleVarName "";
_str = str _man;
_man setVehicleVarName _vvn;

_index = parseNumber (_str select [(_str find ":") + 1]);

_index;