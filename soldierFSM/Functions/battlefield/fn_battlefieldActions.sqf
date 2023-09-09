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

_battlefield set ["currentAction",    "Assigning marksmen"];
[_battlefield] call SFSM_fnc_activateMarksMen;

_battlefield set ["currentAction",    "Assigning Turrets"];
[_battlefield] call SFSM_fnc_manAllTurrets;/*sleep 1;isNil{
[_battlefield] call SFSM_fnc_leaveBattlefieldTurrets;};*/

_battlefield set ["currentAction",    "Checking overrun"];isNil{
[_battlefield] call SFSM_fnc_battleOverRun;};


_battlefield set ["currentAction",    "Waiting..."];

true;