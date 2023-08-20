/*
*  customCBA.sqf
*  Author: PapaReap
*/

private _versionName = "DCO soldier FSM | Headless Client";
//disable initialization of all HC related functions
[
    "PR_disable_HC",
    "CHECKBOX",
    ["Disable all Headless Client management", "Disables SFSM Headless Client management, does not affect SFSM running on units itself."],
    _versionName,
    true,
    2,
    {},
    true

] call CBA_fnc_addSetting;

[
    "PR_Allow_HC",
    "CHECKBOX",
    ["Allow Headless Client", "Allow Headless Client to process SFSM for AI."],
    _versionName,
    false,
    true,
    {},
    true
] call cba_settings_fnc_init;

[
    "PR_Use_HC",
    "CHECKBOX",
    ["Use Headless Client", "Use Headless Client to process SFSM for AI."],
    _versionName,
    false,
    true,
    {},
    true
] call cba_settings_fnc_init;

[
    "PR_HC1",
    "EDITBOX",
    ["Headless Client name", "Headless Client name, default HC"],
    _versionName,
    "HC",
    true,
    {},
    true
] call cba_settings_fnc_init;
