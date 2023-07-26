if(isNil "SFSM_DebugType")            exitWith{false;};
if(SFSM_DebugType isEqualTo "never")  exitWith{false;};
if(SFSM_DebugType isEqualTo "always") exitWith{true;};

private _curatorMode = !isNull (findDisplay 312);
if(_curatorMode
&&{SFSM_DebugType isEqualTo "curator"}) exitWith{true;};

false;