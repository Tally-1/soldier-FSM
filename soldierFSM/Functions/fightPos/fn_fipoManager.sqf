if(!isNil "SFSM_fipoOn")exitWith{};
SFSM_fipoOn = true;

sleep 3;

if(SFSM_fipositions isEqualTo [])exitWith{SFSM_fipoOn = nil;};

[] spawn SFSM_fnc_fipoFSM;

while {sleep 5; true} do {
   
   [] call SFSM_fnc_fipoAssigner;
};