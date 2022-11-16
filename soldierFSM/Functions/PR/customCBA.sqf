/*
*  customCBA.sqf
*  Author: PapaReap
*/

private _versionName = ["DCO soldier FSM V. ", (missionNamespace getVariable "SFSM_Version")] joinString "";

[
    "PR_Allow_HC",
    "CHECKBOX",
    ["Allow Headless Client", "Allow Headless Client to process SFSM for AI."],
    _versionName,
    false
] call cba_settings_fnc_init;

[
    "PR_Use_HC",
    "CHECKBOX",
    ["Use Headless Client", "Use Headless Client to process SFSM for AI."],
    _versionName,
    false
] call cba_settings_fnc_init;

[
    "PR_HC1",
    "EDITBOX",
    ["Headless Client name", "Headless Client name, default HC"],
    _versionName,
    "HC"
] call cba_settings_fnc_init;