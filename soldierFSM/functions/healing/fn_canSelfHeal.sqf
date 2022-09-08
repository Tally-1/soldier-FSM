params ["_man"];
private _hasMedkit = ("FirstAidKit" in (items _man) 
					 or "Medikit" 	in (items _man));

(_hasMedkit && {SFSM_legHealingOn})