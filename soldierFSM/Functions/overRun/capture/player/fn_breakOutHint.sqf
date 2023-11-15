params["_timeLimit", "_maxTime"];
private _remaining = _timeLimit-time;
private _remPrcnt  = ceil(100 - ((_remaining/_maxTime)*100));

if(_remPrcnt>100)then{_remPrcnt=100;};

private _msg       = parseText([
"Attempting to break the cuffs!","<br/>",
"Keep holding the key down!","<br/>",
_remPrcnt,"%"
]joinString"");

hint _msg;

_remPrcnt;