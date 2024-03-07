if(!isNil "SFSM_fipoOn")exitWith{};
SFSM_fipoOn = true;

sleep 3;

// if(SFSM_fipositions isEqualTo [])exitWith{SFSM_fipoOn = nil;};

[] spawn SFSM_fnc_fipoFSM;

[]spawn{while {true} do {
   // [] call SFSM_fnc_AssigAllFipos;
   // [] spawn SFSM_fnc_unitToFipoAssigner;
   [SFSM_activeAzFipos, true] call SFSM_fnc_fipoAssigner;
   sleep 1;   
}};

private _assignAllTime = time + 60;
// forever loop, priority is put on the activation Zone FIPOS (Newest feature)
while {sleep 2; true} do {
   // [true] call SFSM_fnc_handleActivationZones;
   SFSM_fipositions = SFSM_fipositions select {!isNull _x;};
   [SFSM_fipositions, true] call SFSM_fnc_fipoAssigner;

   if(time > _assignAllTime)
   then{
      SFSM_allFipos = SFSM_allFipos select {!isNull _x;};
      [SFSM_allFipos, true] call SFSM_fnc_fipoAssigner;
      _assignAllTime = time + 120;
      "Assigned all FIPOs" call dbgmsg;
   };
};