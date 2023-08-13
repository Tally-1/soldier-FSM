/*
    ReturnValue:
    name of event | when   | change in morale | how long the effect lasts 
    [_eventName, _eventTime, _moraleChange, _eventTimeOut]
*/
params["_man", "_event"];
// Positive events 
if(_event isEqualTo "enemy-killed")         exitWith{[_event, time, 0.5, 60]};
if(_event isEqualTo "enemy-captured")       exitWith{[_event, time, 0.5, 60]};
if(_event isEqualTo "revived")              exitWith{[_event, time, 0.5, 60]};
if(_event isEqualTo "friendly-revived")     exitWith{[_event, time, 0.3, 30]};
if(_event isEqualTo "enemy-knocked-out")    exitWith{[_event, time, 0.3, 30]};
if(_event isEqualTo "enemy-hit")            exitWith{[_event, time, 0.1, 20]};// Only affects the shooter

// Negative events 
if(_event isEqualTo "knocked-out")          exitWith{[_event, time, 0-(0.5), 180] };
if(_event isEqualTo "friendly-killed")      exitWith{[_event, time, 0-(0.5), 60]  };
if(_event isEqualTo "friendly-captured")    exitWith{[_event, time, 0-(0.5), 60]  };
if(_event isEqualTo "friendly-knocked-out") exitWith{[_event, time, 0-(0.3), 30]  };
if(_event isEqualTo "hit-by-enemy")         exitWith{[_event, time, 0-(0.1), 20]  };
