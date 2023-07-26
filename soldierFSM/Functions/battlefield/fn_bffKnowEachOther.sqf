params ["_unit", "_target"];
if(SFSM_BFFknowledgeType isEqualTo "one side")exitWith{true;};

private _minKnowledge = selectMin [
        (_unit knowsAbout _target),
        (_target knowsAbout _unit)
    ];

// one of the two does not have complete knowledge of the other.
if (_minKnowledge < 3.95) exitWith {
    private _dbgmsg = "Battle init blocked, one of the two sides does not know about the other";
    [_dbgmsg, 2] call dbgmsg;
    false;
};

true;