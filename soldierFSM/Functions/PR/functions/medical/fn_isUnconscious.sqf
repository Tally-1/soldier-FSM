/*
*  fn_isUnconscious.sqf
*  Author: PapaReap
*  Function names: pr_medical_fnc_isUnconscious
*  Checks if unit is unconscious
*  Unconscious, bleeding & pain - Usage: [_unit] call pr_medical_fnc_isUnconscious

*  lifeState player = "INCAPACITATED"
*/

params ["_unit"];

if(! SFSM_aceLoaded)exitWith{false;};
if(_unit getVariable "ace_isunconscious")exitWith{true;};

private _return = false;

if (
    (_unit getVariable ["PR_medical_isUnconscious", false]) // PR Medical
    || { (lifeState _unit == "INCAPACITATED") } // Default Arma III
    || { (_unit getVariable ["ACE_isUnconscious", false]) } // ACE 3
    || { (_unit getVariable ["dam_ignore_injured0", false]) } // Personal Injury Reaction (PIR)
) then {
    _return = true;
} else {
    _return = false;
};

_return
