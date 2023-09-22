params ['_battleField'];

_battlefield set ["currentAction",    "Updating Grid"];isNil{
[_battleField] call SFSM_fnc_updateGrid;};

_battlefield set ["currentAction",    "Medical actions"];isNil{
[_battleField] call SFSM_fnc_battleFieldMedical};

_battlefield set ["currentAction",    "Assigning CQB"];
[_battleField] call SFSM_fnc_battleFieldCQB;

_battlefield set ["currentAction",    "Assigning vehicles"];isNil{
[_battleField] call SFSM_fnc_hijackAllVehicles;};
       
_battlefield set ["currentAction",    "Reinforcing vehicles"];isNil{
[_battleField] call SFSM_fnc_reinforceVehicles;};

//The marksman FSM needs to be spawned in a separate thread being that it takes 
//so long.
if!(_battlefield getOrDefault ["marksmenLoop", false])then{
	_battlefield set ["currentAction",    "Activating marksmen"];
	[_battlefield] spawn SFSM_fnc_activateMarksMen;
	sleep 5;
};


_battlefield set ["currentAction",    "Assigning Turrets"];
[_battlefield] call SFSM_fnc_manAllTurrets;/*sleep 1;isNil{
[_battlefield] call SFSM_fnc_leaveBattlefieldTurrets;};*/

_battlefield set ["currentAction",    "Checking overrun"];isNil{
[_battlefield] call SFSM_fnc_battleOverRun;};


_battlefield set ["currentAction",    "Waiting..."];

sleep 1;

true;