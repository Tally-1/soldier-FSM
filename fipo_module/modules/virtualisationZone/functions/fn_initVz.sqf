 // I may do a 3den-debug function here later
if!(is3DEN)   exitWith{};
params[
	["_mode",  "", [""]],
	["_input", [], [[]]]
];
_input
params[
	["_module",          objNull,[objNull]], // Module logic
	["_isActivated",     true,      [true]], // True when the module was activated, false when it is deactivated
	["_isCuratorPlaced", false,     [true]]  // True if the module was placed by Zeus
];