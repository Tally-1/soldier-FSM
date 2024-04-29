// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _tenSecondTimer = time + 10;
private _minuteTimer    = time + 60;
private _fiveMinTimer   = time + 300;

while {true}
do {
        private _startTime = time;
        
        if(time > _tenSecondTimer)
        then{
                _tenSecondTimer = time + 10;
                [] call SFSM_fnc_tenSecondTasks;
            };
        
        if(time > _minuteTimer)
        then{
                _minuteTimer    = time + 60;
                [] call SFSM_fnc_minuteTasks;
            };
        
        
        if(time > _fiveMinTimer)
        then{
                _fiveMinTimer   = time + 300;
                [] call SFSM_fnc_fiveMinTasks;                
            };
        
        private _timeSpent = time - _startTime;
        private _sleep     = 1 - _timeSpent;

        if(_sleep > 0)then{sleep _sleep;};

};