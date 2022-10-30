params["_man", "_building"];
if!(SFSM_houseDemolition)exitWith{false;};
if(!alive _man) exitWith {false;};
if([_man] call SFSM_fnc_getChargeFromBackPack isEqualTo []) exitWith {false;};
if(((getPosATL _building)#3)<0)exitWith{false;};

//Random coef based on the courage of the unit.
private _braveEnough = (_man skill "courage")>=(random 1);
if!(_braveEnough)exitWith{"no demo, no courage" call dbgmsg; false;};

true;