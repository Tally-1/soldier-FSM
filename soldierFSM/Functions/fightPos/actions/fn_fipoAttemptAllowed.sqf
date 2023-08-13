params["_fipo"];

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