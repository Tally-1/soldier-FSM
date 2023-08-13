// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_action"];
private _default     = [0.5, 0.6, 0.4, 1];
private _orange      = [0.85, 0.4, 0, 1];
private _lightOrange = [0.9,  0.6,  0.3,  1];
private _red         = [0.9, 0.1, 0.1, 1];
private _brown       = [0.5, 0.25, 0, 1];
private _darkGreen   = [0.1, 0.5, 0, 1];
private _medGreen    = [0.2, 0.6, 0, 1];
private _green       = [0.3, 0.8, 0, 1];
private _blue        = [0, 0, 1, 1];
private _lightBlue   = [0.3, 0.3, 1, 1];
private _aqua        = [0.4, 1, 0.9, 1];
private _greenTeal   = [0.5, 1, 0.3, 1];


if(""                          isEqualTo _action)    exitWith{_default};

/*------------------------------------------------------------------------*/

if("return fire"              isEqualTo _action)    exitWith{[0.8,0.3,0.4,1]};
if("return direct fire"       isEqualTo _action)    exitWith{[0.4,0.3,0.8,1]};
if("reacting"                 isEqualTo _action)    exitWith{[0.3,0.3,0.8,1]};
if("flinch"                   isEqualTo _action)    exitWith{[0.6,0.2,0.2,1]};

/*------------------------------------------------------------------------*/

if("! Suppressed !"           isEqualTo _action)    exitWith{_red};
if("Fleeing  "                isEqualTo _action)    exitWith{_lightOrange};
if("Fleeing"                  isEqualTo _action)    exitWith{_red};
if("dodging"                  isEqualTo _action)    exitWith{_orange};
if("Evading fire"             isEqualTo _action)    exitWith{[0.99,0.48,0.48,1]};
if("rearming"                 isEqualTo _action)    exitWith{_orange};
if("Moving to fire-position"  isEqualTo _action)    exitWith{_orange};
if("emergency heal"           isEqualTo _action)    exitWith{_red};
if("dodging to cover"         isEqualTo _action)    exitWith{_brown};
if("No cover panic!"          isEqualTo _action)    exitWith{_red};
if("Sprinting!!"              isEqualTo _action)    exitWith{_medGreen};
if("no targets..."            isEqualTo _action)    exitWith{_brown};
if("Engaging target"          isEqualTo _action)    exitWith{_lightOrange};
if("Target reassigned"        isEqualTo _action)    exitWith{_darkGreen};
if("Resetting brain"          isEqualTo _action)    exitWith{_aqua};
if("Brain reset"              isEqualTo _action)    exitWith{_green};
if("Back in action"           isEqualTo _action)    exitWith{_green};
if("!PANIC!"                  isEqualTo _action)    exitWith{_red};

/*------------------------------------------------------------------------*/

if("fiPo"                 in _action)             exitWith{_darkGreen};
if("house is about to ex" in _action)             exitWith{_red};
if("earching for targets" in _action)             exitWith{_darkGreen};
if("Picking up"           in _action)             exitWith{_orange};
if("leaving"              in _action)             exitWith{_lightBlue};
if("success"              in _action)             exitWith{_green};
if("completed"            in _action)             exitWith{_green};
if("taking cover"         in _action)             exitWith{_brown};
if("CQB"                  in _action)             exitWith{_darkGreen};
if("failed"               in toLowerANSI _action) exitWith{_red};
if("dodging"              in toLowerANSI _action) exitWith{_aqua};
if("explosive"            in _action)             exitWith{_orange};
if("Hiding"               in _action)             exitWith{_brown};
if("uppressi"             in _action)             exitWith{_blue};
if("!Targeting Enemy!"    in _action)             exitWith{_red};
if("Targeting"            in _action)             exitWith{_blue};
if("Moving to position"   in _action)             exitWith{_brown};
if("Hunting"              in _action)             exitWith{_orange};



_default