// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man"];
private _sideStances = [
    "aadjppnemstpsraswrfldleft",
    "aadjppnemwlksraswrfldleft_f",
    "aadjppnemstpsraswrfldright",
    "aadjppnemwlksraswrfldright_f", 
    "aadjppnemstpsraswrflddown_amovppnemstpsraswrfldnon",
    "aadjppnemstpsraswrflddown"
];
// _man setUnitPos "AUTO";
if(animationState _man in _sideStances
&& {stance _man == "PRONE"})
then{_man playMoveNow "amovppnemstpsraswrfldnon"};
