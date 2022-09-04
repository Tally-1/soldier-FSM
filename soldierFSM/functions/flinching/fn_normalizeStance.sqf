params["_man"];
private _sideStances = [
	"aadjppnemstpsraswrfldleft",
	"aadjppnemwlksraswrfldleft_f",
	"aadjppnemstpsraswrfldright",
	"aadjppnemwlksraswrfldright_f", 
	"aadjppnemstpsraswrflddown_amovppnemstpsraswrfldnon"
];
// _man setUnitPos "AUTO";
if(animationState _man in _sideStances
&& {stance _man == "PRONE"})
then{_man playMoveNow "amovppnemstpsraswrfldnon"};
