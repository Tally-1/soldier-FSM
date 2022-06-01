#include "\a3\editor_f\Data\Scripts\dikCodes.h"
private _modName 		= "soldier FSM";
private _actionId 		= "76";
private _displayName 	= "";
private _downCode 		= {Hint "It works!!!"};
private _upCode 		= "";
private _defaultKeybind = [DIK_B, [true, true, false]];


[
	_modName,		//Name of the registering mod [String]
	_actionId,	  	//Id of the key action. [String]
	_displayName, 	//Pretty name, or an array of strings for the pretty name and a tool tip [String]
	_downCode,		//Code for down event, empty string for no code. [Code]
	_upCode			//Code for up event, empty string for no code. [Code]
	_defaultKeybind //The keybinding data in the format [DIK, [shift, ctrl, alt]] [Array]
]
call CBA_fnc_addKeybind;

/*

EXAMPLE:

[
	"My Awesome Mod",
	"show_breathing_key", 
	"Show Breathing", 
	{_this call mymod_fnc_showGameHint}, 
	"", 
	[DIK_B, [true, true, false]]
] 
call CBA_fnc_addKeybind;


DOCUMENTATION:

https://github-wiki-see.page/m/CBATeam/CBA_A3/wiki/Keybinding


*/