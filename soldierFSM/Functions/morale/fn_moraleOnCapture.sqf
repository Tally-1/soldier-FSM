params ["_captive", "_captor"];
private _entities = _captive nearEntities 100;
_entities insert  [0, (units group _captive),  true];
_entities insert  [0, (units group _captor),   true];

{
    if([_x] call SFSM_fnc_functionalMan
    &&{ true//_x knowsAbout _captive isEqualTo 4
	})then{
    
        if([_captive, _x] call SFSM_fnc_hostile)
        then{[_x, "enemy-captured"]    call SFSM_fnc_moraleEvent}
        else{[_x, "friendly-captured"] call SFSM_fnc_moraleEvent}

}}
forEach _entities;

true;