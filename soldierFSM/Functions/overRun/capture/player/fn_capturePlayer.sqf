params["_player", "_captor"];
if(_player isNotEqualTo player) exitWith{false;};
if!(hasInterface)               exitWith{false;};

hint parseText("You have been captured!<br/>Use the A S W D buttons to break free");

player setVariable ["SFSM_myCaptor", _captor, true];
[player, _captor] call SFSM_fnc_playerCaptureKeyHandlers;

true;