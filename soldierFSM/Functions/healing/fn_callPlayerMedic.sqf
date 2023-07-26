private _healer = [player] call SFSM_fnc_getGroupHealer;
if(isNil "_healer")exitWith{hint "No healer available."};

[_healer, "Healing player"] call SFSM_fnc_setAction;

SFSM_playerHealing = true;

private _moveToPlayer = [_healer, player] spawn SFSM_fnc_moveToMan;

waitUntil{
    sleep 0.1;
    [_healer] call SFSM_fnc_playerHealHint;
    scriptDone _moveToPlayer || {!([_healer] call SFSM_fnc_canRun)};
};

if(_healer distance player > 10)exitWith{
    [_healer, "none"] call SFSM_fnc_setAction;
    hint "Healing failed, healer is too far away";
    };

hint "Stand still, healing...";
_healer action ["HealSoldier", player];
sleep 5;
hint "Healing complete!";

sleep 5;
SFSM_playerHealing = false;
[_healer, "none"] call SFSM_fnc_setAction;

_healer doFollow (leader group _healer);
_healer doFollow (leader group _healer);
true;