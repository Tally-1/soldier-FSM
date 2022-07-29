params["_man", "_success", "_weapon"];
private _statusText = "failed picking up weapon";

if(_success)
then{_statusText = "Picked up weapon successFully!"};

[_man, "action", _statusText] call SFSM_fnc_unitData;
_man setAnimSpeedCoef 1;
sleep 1;
[_man, "action", "none"] call SFSM_fnc_unitData;
[_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;
_man doMove (getPos _man);
_man doFollow (leader (group _man));

if((!isNil "_weapon")
&&{!isNull _weapon})
then{_weaponObject setVariable ["SFSM_newOwner", nil]}