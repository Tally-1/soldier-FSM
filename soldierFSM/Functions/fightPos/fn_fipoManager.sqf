if(!isNil "SFSM_fipoOn")exitWith{};
SFSM_fipoOn = true;

sleep 3;

[] spawn SFSM_fnc_fipoFSM;

while {true} do {

   {
      [_x] call SFSM_fnc_groupFipoAssigner;
      sleep 0.2;
   } forEach allGroups;

   sleep 5;
};