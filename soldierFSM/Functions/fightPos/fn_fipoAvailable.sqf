params["_fipo"];
private _fipoMan = [_fipo] call SFSM_fnc_fipoMan;
if(!isNil "_fipoMan")exitWith{false;};

//Positions marked as hit and run will have a cooldown
private _remainingCoolDown = [_fipo] call SFSM_fnc_fipoCooldownLeft;
if(_remainingCoolDown > 0) exitWith{false;};


//To avoid get-in spam the following code is implemented.
private _attemptsFipo = _fipo getVariable ["getInAttempts", []];
if(_attemptsFipo isEqualTo [])exitWith{true;};

private _firstAttempt  = _attemptsFipo#0;
private _timeSinceFirst= time - _firstAttempt;

if(_timeSinceFirst > 300)then{_attemptsFipo deleteAt 0};
if(_attemptsFipo isEqualTo [])exitWith{true;};

private _lastAttempt   = _attemptsFipo#(count _attemptsFipo -1);
private _timeSinceLast = time - _lastAttempt;
private _attempts      = count _attemptsFipo;

if(_attempts > 3
&&{_timeSinceLast < 120}) exitWith{false;};
if(_timeSinceLast < 30)   exitWith{false;};



true;