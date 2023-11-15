params["_man"];
// boot unconscious from vehicles so they can be revived, 
// and the vehicle can be re-crewed.
if (typeOf _man isNotEqualTo (typeOf vehicle _man)
&& {(getPosATL _man)#2<2
&& {!(_man in allPlayers)}})
then{_man action ["Eject", vehicle _man];};

[_man, false] spawn SFSM_fnc_unconAiAbility;
[_man]        call SFSM_fnc_fipoKnockOut;
[_man]        call SFSM_fnc_moraleOnKnockOut;
true;