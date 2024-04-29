
private _zigZagAnims = [
        "AmovPercMtacSrasWrflDr",
        "AmovPercMtacSrasWrflDl",
        "AmovPercMtacSrasWrflDr"
];

private _zigZagPushAnimsR = [
    "AmovPercMevaSrasWrflDfr_AmovPknlMstpSrasWrflDnon",
    "AmovPercMevaSrasWrflDfl",
    "AmovPercMevaSrasWrflDfl_AmovPknlMstpSrasWrflDnon"
];

private _zigZagPushAnimsL = [
    "AmovPercMevaSrasWrflDfl_AmovPknlMstpSrasWrflDnon",
    "AmovPercMevaSrasWrflDfr",
    "AmovPercMevaSrasWrflDfr_AmovPknlMstpSrasWrflDnon"
];

private _rightFlankAnims = [
        "AmovPercMtacSrasWrflDfr",
        "AmovPercMtacSrasWrflDfr",
        "AmovPercMtacSrasWrflDfr",
        "AmovPercMtacSrasWrflDr",
        "AmovPercMtacSrasWrflDr",
        "AmovPercMevaSrasWrflDfr_AmovPknlMstpSrasWrflDnon"
];
private _leftFlankAnims = [
        "AmovPercMtacSrasWrflDfl",
        "AmovPercMtacSrasWrflDfl",
        "AmovPercMtacSrasWrflDfl",
        "AmovPercMtacSrasWrflDl",
        "AmovPercMtacSrasWrflDl",
        "AmovPercMevaSrasWrflDfl_AmovPknlMstpSrasWrflDnon"
];

private _dataArr = [];
if(SFSM_EA_ZigZag)
then{_dataArr pushBack["zig-zag",(["zig-zag", _zigZagAnims]call SFSM_fnc_attackAnimMap)]};
if(SFSM_EA_feintPushRight)
then{_dataArr pushBack["zig-zag-push-right",(["zig-zag-push-right", _zigZagPushAnimsR] call SFSM_fnc_attackAnimMap)]};
if(SFSM_EA_feintPushLeft)
then{_dataArr pushBack["zig-zag-push-left",(["zig-zag-push-left",_zigZagPushAnimsL]call SFSM_fnc_attackAnimMap)]};
if(SFSM_EA_flankRight)
then{_dataArr pushBack["flank right",(["flank right",_rightFlankAnims]call SFSM_fnc_attackAnimMap)]};
if(SFSM_EA_flankLeft)
then{_dataArr pushBack["flank left",(["flank left",_leftFlankAnims]call SFSM_fnc_attackAnimMap)]};

SFSM_attackAnims = createHashmapObject [_dataArr];

true;