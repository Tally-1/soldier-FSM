if!([player] call SFSM_fnc_canCallBuddyRearm)exitWith{
    "no rearm possible..." call dbgmsg;
};

private _buddy = [player] call SFSM_fnc_getRearmingBuddy;
[_buddy, "action", "Rearming player"] call SFSM_fnc_unitData;

private _weapon = currentWeapon player;
private _moveToPlayer = [_buddy, player] spawn SFSM_fnc_moveToMan;

waitUntil{
    sleep 0.1;
    [_buddy] call SFSM_fnc_buddyRearmHint;
    scriptDone _moveToPlayer || {(!alive _buddy) || {[_buddy] call SFSM_fnc_isUncon}};
};

private _magArr   = [_buddy, _weapon] call SFSM_fnc_availMagsForWeapon;
private _transfer = [_buddy, player, _magArr] spawn SFSM_fnc_giveMagazines;
waitUntil { scriptDone _transfer; };

[_buddy, "action", "none"] call SFSM_fnc_unitData;
_buddy doFollow (leader group _buddy);

true;