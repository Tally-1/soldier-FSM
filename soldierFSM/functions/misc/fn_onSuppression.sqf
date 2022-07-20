params ["_man", "_ammoCFG", "_shooter"];
if(isPlayer _man)exitwith{};
if!(typeOf (vehicle _man) == typeOf _man)exitwith{};//if man is in a vehicle

private _rps 		 = [_man, "roundsPrSecond"] call SFSM_fnc_unitData;
private _suppression = (getSuppression _man);
private _lastBullet	 = [_man, "Last_Close_Bullet"] call SFSM_fnc_unitData;

if((time - _lastBullet) < 1 )
then{_rps = _rps + 1}
else{_rps = 1};

//Store new values into unit-hashMap
[_man, "roundsPrSecond", _rps] 				call SFSM_fnc_unitData;
[_man, "Last_Close_Bullet", time] 			call SFSM_fnc_unitData;
[_man, "current suppression", _suppression]	call SFSM_fnc_unitData;


//Select course of action
[_man, _ammoCFG, _shooter] call SFSM_fnc_initReaction;
true;