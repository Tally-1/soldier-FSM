params ["_man"];
if(_man getVariable ["SFSM_Excluded",false])exitWith{false};

private _hasMedkit = ("FirstAidKit" in (items _man) 
					 or "Medikit" 	in (items _man));

(_hasMedkit && {SFSM_legHealingOn})