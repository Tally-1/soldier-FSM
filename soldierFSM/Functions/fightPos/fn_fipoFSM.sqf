sleep 5;
while {sleep 1; true} do {
   private _fipoMen = [] call SFSM_fnc_getFipoMen;
   isNil{[_fipoMen] call SFSM_fnc_fipoMenRegroup;};
   
   sleep 0.1;

   // The "inFipo" notation in the unitData hashmap is only assigned 
   // once the man is definetly inside the fipo, and removed once he is
   // no longer bound to the fipo, making it the best way to find a active 
   // fipo man.
   _fipoMen = _fipoMen select {[_x, "inFipo"] call SFSM_fnc_unitData;};
   
   {isNil{[_x] call SFSM_fnc_fipoActions;}} forEach _fipoMen;

};