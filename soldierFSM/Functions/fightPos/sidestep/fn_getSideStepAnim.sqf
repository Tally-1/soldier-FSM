params[
    ["_unitPos",   nil,    [""]],
    ["_moveRight", true, [true]]
];
private _dirLetter = "r";
private _animBase  = "AmovPercMevaSrasWrflD";

if(_moveRight isEqualTo false)    then{_dirLetter = "l";};
if(_unitPos   isEqualTo "MIDDLE") then{_animBase = "AmovPknlMrunsraswrfld";};
if(_unitPos   isEqualTo "DOWN")   then{_animBase = "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflD";};

private _sideStepAnim = [_animBase, _dirLetter]joinString "";

_sideStepAnim;