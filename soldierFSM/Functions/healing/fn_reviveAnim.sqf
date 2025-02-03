// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

Params ["_man", "_wounded"]; 
_man attachTo [_wounded, [0,1.2,0]];
_man setDir 180;

_man action ['SWITCHWEAPON', _man, _man, 1];
_man switchMove  "AmovPercMstpSrasWrflDnon";
_man playMoveNow "AinvPknlMstpSnonWrflDnon_medic2";

sleep 3;

private _timer = time + 10;
waitUntil {
	sleep 0.1; 
	private _anim = toLowerANSI animationState _man;
	("medic" in _anim isEqualTo false) ||
	(_timer < time);
};

detach _man;

_man switchMove "AmovPknlMstpSrasWrflDnon";

true;