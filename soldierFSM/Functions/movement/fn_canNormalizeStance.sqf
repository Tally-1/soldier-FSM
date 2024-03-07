params[
	["_man", nil, [objNull]]
];

if!([_man] call SFSM_fnc_functionalMan)exitWith{false;};

private _proneTreshHold  = [_man] call SFSM_fnc_getProneTreshHold;
private _suppression     = getSuppression _man;
private _timeSinceFlinch = time - ([_man, "lastFlinch"] call SFSM_fnc_unitData);
private _cooldownEnded   = !isNil "_timeSinceFlinch" && {_timeSinceFlinch > 4};
private _excluded        = _man getVariable ["SFSM_Excluded", false];
private _noAutoStance    = _man getVariable ["SFSM_noAutoStance", false];
private _action          = [_man] call SFSM_fnc_getAction;
private _excludedActions = ["Holding cover position", 'holding hide-position'];
private _wrongAction     = _action in _excludedActions;

if(time < 60)                      exitWith{false;}; // Make sure traits module has initialized
if(_wrongAction)                   exitWith{false;}; // Hiding units do not normalize
if(_excluded)                      exitWith{false;}; // Excluded units do not normalize
if(_noAutoStance)                  exitWith{false;}; // For units altered using traits module 
if(_suppression > _proneTreshHold) exitWith{false;}; // Suppressed units do not normalize
if([_man] call SFSM_fnc_inFipo)    exitWith{false;}; // FIPO units do not normalize
if(_cooldownEnded isEqualTo false) exitWith{false;}; // Recent flinch units do not normalize


true;