params["_buddy"];
private _bigTxt = "<t size='1.5'>";
private _smallTxt = "<t size='0.75'>";
private _versionName = ["soldier FSM V. ", SFSM_Version] joinString "";
private _outLine  = "<t shadow='2'>";
private _aqua     = "<t color='#00ffff'>";
private _khaki    = "<t color='#acffa4'>";
private _green    = "<t color='#83ff7f'>";
private _red      = "<t color='#c53f3f'>";
private _lightRed = "<t color='#fe4040'>";
private _end      = "</t>";

private _distance = round (player distance _buddy);
private _text = parseText ([
    _outLine, _aqua, _bigTxt, "Ammo incoming!", _end,_end,
    "<br/>","<br/>", _khaki, name _buddy, _end, " is on his way with your ammo.",
    "<br/>", "He is ",_green, _distance, _end," meters away.",
    "<br/>","<br/>",_smallTxt, _versionName, _end
]joinString"");

if((!alive _buddy)
||{[_buddy] call SFSM_fnc_isUncon})then{

private _status = " is incapacitated...";
if(!alive _buddy)then{_status = " died...";};

_text = parseText ([
    _outLine, _red, _bigTxt, "Rearming aborted!", _end,_end,
    "<br/>","<br/>",_khaki, name _buddy, _end, _lightRed, _status,_end,
    "<br/>","<br/>", "Feel free to take ammo from his body...",
    "<br/>","<br/>",_smallTxt, _versionName, _end
]joinString"");
};

hint _text;

true;