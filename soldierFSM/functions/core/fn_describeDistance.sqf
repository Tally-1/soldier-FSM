params["_distance"];
private _description = "0m";
private _km = [(_distance / 1000), 1] call Tcore_fnc_decimals;
private _m  = round(_distance);

if(_distance < 1000)
exitWith{
            _description = [_m, " meters"] joinString "";
            _description;
        };

_description = [_km, " kilometers"] joinString "";
_description;