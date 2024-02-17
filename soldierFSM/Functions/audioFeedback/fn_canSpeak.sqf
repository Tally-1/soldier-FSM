params["_man"];
if (_man getVariable ["A3TTS_IsSpeaking", false])        exitWith{false;};
if!(SFSM_audioFeedbackType in ["voice_text", "voice"])   exitWith{false;};
if!([_man, true, true, true, true] call SFSM_fnc_canRun) exitWith{false;};
if ([_man, true] call SFSM_fnc_isPlayer)                 exitWith{false;};
if (SFSM_Debugger)                                       exitWith{true;};


private _players = allPlayers select {(_x distance _man) < 50};
if(_players isEqualTo [])exitWith{false;};

true;