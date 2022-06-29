params["_man"];
private _lockedAnims = ["aadjppnemstpsraswrfldleft", "aadjppnemstpsraswrflddown", "aadjppnemstpsraswrfldright"];
_man setUnitPos "AUTO";
if(animationState _man in _lockedAnims
&& {stance _man == "PRONE"})
then{_man playMove "AadjPpneMstpSrasWrflDleft_AmovPknlMstpSrasWrflDnon"};