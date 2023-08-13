params["_man", "_fipo"]; 
_fipo setVariable ["SFSM_lastVisit", time];

// _fipo setVariable ["SFSM_firstShot", nil];
_fipo setVariable ["shotsFired",     nil];
_fipo setVariable ["getInTime",      nil];

private _firedEh = (_man getVariable "SFSM_fipoFiredHrEh");

if(!isNil "_firedEh")then{
_man removeEventHandler ["Fired", _firedEh];
_man setVariable ["SFSM_fipoFiredHrEh", nil];
};
