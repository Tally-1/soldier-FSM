private _zigZagAnims = [
        "AmovPercMtacSrasWrflDr",
        "AmovPercMtacSrasWrflDl",
        "AmovPercMtacSrasWrflDr"
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

private _dataArr = [
    ["zig-zag",     (["zig-zag",     _zigZagAnims] call SFSM_fnc_attackAnimMap)],
    ["flank right", (["flank right", _rightFlankAnims] call SFSM_fnc_attackAnimMap)],
    ["flank left",  (["flank left",  _leftFlankAnims] call SFSM_fnc_attackAnimMap)]
];

SFSM_attackAnims = createHashmapObject [_dataArr];

true;