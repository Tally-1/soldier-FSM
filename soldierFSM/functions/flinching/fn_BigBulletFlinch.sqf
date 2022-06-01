params ["_man"];
_man disableAI "FSM"; 
private _move 		= "";
private _standmoves = [	"AmovPercMstpSrasWrflDnon_AadjPpneMstpSrasWrflDright",
						"AmovPercMstpSrasWrflDnon_AadjPpneMstpSrasWrflDleft",
						"AmovPercMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon"];

private _kneelMoves = [	"AmovPknlMstpSrasWrflDnon_AadjPpneMstpSrasWrflDleft",
						"AmovPknlMstpSrasWrflDnon_AadjPpneMstpSrasWrflDright"];

private _proneMoves = [	"AmovPpneMstpSrasWrflDnon_AadjPpneMstpSrasWrflDdown",
						"AmovPpneMstpSrasWrflDnon_AadjPpneMstpSrasWrflDleft",
						"AmovPpneMstpSrasWrflDnon_AadjPpneMstpSrasWrflDRight"];

switch (stance _man) do {
	case "STAND": 	{_move = selectRandom _standmoves};
	case "CROUCH": 	{_move = selectRandom _kneelMoves};
	case "PRONE": 	{_move = selectRandom _proneMoves};
}; 

_man playMove _move;

true;