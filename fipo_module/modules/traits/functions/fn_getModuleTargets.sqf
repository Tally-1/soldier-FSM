params["_module"];
private _synched     = (synchronizedObjects _module);
private _targetClass = _module getVariable "TMOD_syncTo";

if(_synched isEqualTo [])exitWith{[];};

if(_targetClass isEqualTo "man")exitWith{_synched;};

if(_targetClass isEqualTo "group")exitWith{
    private _man   = (_synched select {_x isKindOf "caManBase"})#0;
    private _units = units group _man;
    
    _units;
};

if(_targetClass isEqualTo "faction")exitWith{
    private _wantedFaction = faction ((_synched select {_x isKindOf "caManBase"})#0);
    private _units = allUnits select {
        _x isKindOf "caManBase"
        &&{(faction _x) isEqualTo _wantedFaction}};
    
    _units;
};

private _wantedSide = side ((_synched select {_x isKindOf "caManBase"})#0);
private _units = allUnits select {
        _x isKindOf "caManBase"
        &&{(side _x) == _wantedSide
        }};

_units;