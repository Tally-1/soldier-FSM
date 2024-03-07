params[
	["_man", nil, [objNull]]
];
if(SFSM_audioFeedbackType isEqualTo "none")           exitWith{false;};
if(SFSM_audioFeedbackType in ["voice_text", "voice"]) exitWith{true;};

private _language      = [_man] call SFSM_fnc_languageMan;
private _speaksEnglish = _language in ["english", "unknown"];

_speaksEnglish;