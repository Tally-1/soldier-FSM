// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man"];

if(lifeState _man == "INCAPACITATED")                   exitWith{true;}; // Default Arma III
if(_man getVariable ["ace_isunconscious", false])       exitWith{true;}; // ACE 3
if(_man getVariable ["ACE_isUnconscious", false])       exitWith{true;}; // ACE 3
if(_man getVariable ["dam_ignore_injured0", false])     exitWith{true;}; // Personal Injury Reaction (PIR)
if(_man getVariable ["vn_revive_incapacitated", false]) exitWith{true;}; // SOG DLC

false;