params[
    "_fipo", 
    "_text",
    ["_color", [1,1,1,1]],
    "_icon"
];

if(SFSM_debugger isEqualTo false)exitWith{};

private _flashData = _fipo getVariable ["flashData", []];
if(_flashData isNotEqualTo [])
then{
    sleep 1;
    _fipo setVariable ["flashData", [], true];
};

private _defaultIcon = ([_this#0] call SFSM_fnc_fipoDebugData)#3;
if(isNil "_icon")then{_icon = _defaultIcon;};

_flashData = [
    _text,
    _color,
    _icon
];

_fipo setVariable ["flashData", _flashData, true];
sleep 3;
_fipo setVariable ["flashData", [], true];

true;