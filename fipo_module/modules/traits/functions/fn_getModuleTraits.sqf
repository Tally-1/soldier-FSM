params["_module"];

private _randomize = _module getVariable "randomize_values";
private _traits = [
    (_module getVariable "aimaccuracy"),
    (_module getVariable "aimspeed"),
    (_module getVariable "aimshake"),
    (_module getVariable "spotdistance"),
    (_module getVariable "spottime"),
    (_module getVariable "reloadspeed"),
    (_module getVariable "courage")
];


if(_randomize isEqualTo false)exitWith{_traits;};

private _randomizedValues = _traits apply {
    private _randomRange  = (_module getVariable "random_skill_value")+0.001;
    private _half         = _randomRange/2;
    private _randomValue  = random _randomRange;
    private _newVal       = (_x - _half)+_randomValue;

    if  (_newVal > 1)
    then{_newVal = 1;};
    if  (_newVal < 0)
    then{_newVal = 0;};

    _newVal = parseNumber (_newVal toFixed 2);
    _newVal;
};

_randomizedValues;