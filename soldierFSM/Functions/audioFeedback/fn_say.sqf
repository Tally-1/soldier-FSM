params ["_man", "_phrase"];

if(!hasInterface)             exitWith{};
if(isNil "SFSM_fnc_SquadSay") exitWith{};
if(!alive player)             exitWith{};

private _camPos = (positionCameraToWorld [0,0,0]);
if(_camPos distance2D _man > 50)exitWith{};


_man setVariable ["A3TTS_IsSpeaking", true, true];
_man setRandomLip true;

if(SFSM_audioFeedbackType isEqualTo "voice_text")
then{_man directSay _phrase}
else{_man say3D _phrase};

sleep 3;

_man setVariable ["A3TTS_IsSpeaking", false, true];
_man setRandomLip false;

true;