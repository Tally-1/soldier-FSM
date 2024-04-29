private _print = true;
private _log   = true;
private _displayType = 1;
private _signature = "***Tcore Debug mesage***";

params[ "_text", 
        "_print", 
        "_log", 
        "_displayType",
        "_signature"
      ];


if(typeName _this == "STRING")  then{_text = _this};
if(typeName _text == "ARRAY")    then{_text = _text joinString ""};
if!(typeName _text == "STRING")    then{_text = str _text};


if(_log)then{diag_log [_signature, _text] joinString ""};

if!(_print)exitWith{_text};

switch (_displayType) 
do {
    case 1: { systemChat _text};
    case 2: { hint _text};
};

_text;