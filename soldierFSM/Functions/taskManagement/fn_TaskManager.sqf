// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _tenSecondTimer = 0;
private _fiveMinTimer   = 0;
private _minuteTimer    = 0;

while {true}
do {
        private _startTime = time;
        if(_tenSecondTimer isEqualTo 10)
        then{
                private _script = [] spawn SFSM_fnc_tenSecondTasks;
                waitUntil{scriptDone _script};
                _tenSecondTimer = 0;
            };
        
        if(_minuteTimer isEqualTo 60)
        then{
                private _script = [] spawn SFSM_fnc_minuteTasks;
                waitUntil{scriptDone _script};
                _minuteTimer = 0;
            };
        
        
        if(_fiveMinTimer isEqualTo 300)
        then{
                private _script = [] spawn SFSM_fnc_fiveMinTasks;
                waitUntil{scriptDone _script};
                _fiveMinTimer = 0;
            };
        
        private _timeSpent = time - _startTime;
        private _sleep     = 1 - _timeSpent;

        if(_sleep > 0)then{sleep _sleep;};       

        _tenSecondTimer = _tenSecondTimer+1;
        _minuteTimer    = _minuteTimer+1;
        _fiveMinTimer   = _fiveMinTimer+1;
       
};