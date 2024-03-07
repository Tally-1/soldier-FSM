private _fipoDataArr = [];
private _azs         = [];
{
    private _data = [_x] call SFSM_fnc_virtualizeFipo;
    private _AzF  = _data get "activationZones";

    if(_AzF isNotEqualTo [])then{_azs pushBackUnique _AzF};

    _fipoDataArr pushBackUnique _data;

} forEach (_self get "physicalFipos");

if(_azs isNotEqualTo []
&&{SFSM_debugger})
then{
    private _warning = parseText([
        "<t size='2' color='#e51313'>",
        "Warning!</t> <br/>",
        "Activation Zones are not compatible with Virtual Zones <br/>",
        "The AZ fipos affected are now useless..."
    ]joinString"");
    hint _warning;
};

_self set ["physicalFipos",           []];
_self set ["virtualFipos",  _fipoDataArr];
_self set ["active",               false];

true;