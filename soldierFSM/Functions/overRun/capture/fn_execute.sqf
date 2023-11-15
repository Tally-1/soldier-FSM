params ["_victim", "_killer"];
// private _text = [(name _killer), " is executing ", name _victim]joinString"";
// [_text] remoteExecCall ["systemChat", 0];
[_victim, "Being executed"] call SFSM_fnc_setAction;

private _gun  = (handgunWeapon _killer);
// private _dmg  = damage _victim;

[_killer, _victim] call SFSM_fnc_executionerKillshot;

[_victim, "none"] call SFSM_fnc_setAction;

if(alive _victim)exitWith{};

[_victim]  remoteExecCall ["removeAllActions", 0];

["execution",  [_victim, _killer]] call CBA_fnc_localEvent;

true;