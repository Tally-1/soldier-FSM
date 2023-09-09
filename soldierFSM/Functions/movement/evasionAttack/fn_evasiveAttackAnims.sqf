params["_moveType"];

if(_moveType isEqualTo "zig-zag")exitWith{
    [
        "AmovPercMtacSrasWrflDr",
        "AmovPercMtacSrasWrflDl",
		"AmovPercMtacSrasWrflDr",
        "AmovPercMtacSrasWrflDl",
        "AmovPercMtacSrasWrflDr",
        "AmovPercMtacSrasWrflDl"
    ];
};

if(_moveType isEqualTo "flank right")exitWith{
    [
        "AmovPercMtacSrasWrflDfr",
        "AmovPercMtacSrasWrflDfr",
		"AmovPercMtacSrasWrflDfr",
        "AmovPercMtacSrasWrflDr",
		"AmovPercMtacSrasWrflDr",
        "AmovPercMevaSrasWrflDfr_AmovPknlMstpSrasWrflDnon"
    ];
};

if(_moveType isEqualTo "flank left")exitWith{
    [
        "AmovPercMtacSrasWrflDfl",
        "AmovPercMtacSrasWrflDfl",
		"AmovPercMtacSrasWrflDfl",
        "AmovPercMtacSrasWrflDl",
		"AmovPercMtacSrasWrflDl",
        "AmovPercMevaSrasWrflDfl_AmovPknlMstpSrasWrflDnon"
    ];
};