params ["_man", "_player","_weapon"];
if(_man distance _player > 100)                        exitWith{false};
if([_man] call SFSM_fnc_isUncon)                       exitWith{false};
if(_man in allPlayers)                                 exitWith{false};
if(([_weapon, _man] call SFSM_fnc_hasMagsForWeapon)<3) exitWith{false};
if!([_man] call SFSM_fnc_isRealMan)                    exitWith{false};
if([_man, "action"] call SFSM_fnc_unitData != "none")  exitWith{false};

true;