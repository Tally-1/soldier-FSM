params["_man", "_event"];
if!([_man] call SFSM_fnc_canSpeak)exitWith{};

private _group   = group _man;
private _phrase  = [_event] call SFSM_fnc_getPhrase;
private _data    = [time, _phrase];

//future speechControll(no say spam from all members);
private _groupData = (_group getVariable "SFSM_groupData");
if(isNil "_groupData")exitWith{};

(_groupData get "lastPhrases") pushBackUnique _data;

[_man, _phrase] remoteExec ["SFSM_fnc_say", 0];