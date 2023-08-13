// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3


// Retrieves or stores data from the SFSM_UnitData hashmap.
// _man is the object containing the hashmap-variable
// _item is the key-value in the hashmap
// _value (optional) is the value to assign to the hashmap-key.

params [
    "_man",    //object(man)
    "_item",  // string (the key in the hashmap)
    "_value" //  (optional) any(except object) (the value to assign to the hashmap-key)
]; 

if(isNil "_man")exitwith{};
if!(_man isKindOf "CAManBase")exitwith{
    // [["Non-man object used in unitdata function. Type: ", typeOf _man]] call dbgMsg;
    nil;
};

private _unitData = (_man getVariable "SFSM_UnitData");
if(isNil "_unitData")exitWith{};

// if _value is nil, then we are retrieving the value, not setting it
private _returnVal = _unitData get _item;
if(isNil "_value")exitwith{_returnVal};

_unitData set [_item, _value];

//experimental performance improvement
if(SFSM_globalUD)
then{_man setVariable["SFSM_UnitData", _unitData, true];}
else{_man setVariable["SFSM_UnitData", _unitData];};

//eh-name        unit    type   prev-value  new-value
if(!isNil "_returnVal")then{
    ["new_unitData", [_man, _item, _returnVal, _value]] call CBA_fnc_localEvent;
};

if(_item  isEqualTo "action"
&&{_value isEqualTo "none"})then{
    ["man_available", [_man]] call CBA_fnc_localEvent;
};

private _flashAction = [_man, "flashAction"] call SFSM_fnc_unitData;

if(isNil "_returnVal" isEqualTo false
&&{_returnVal in ["!PANIC!", "Surrendered", "Captured"]
&&{_value isEqualTo "none"
&&{_item isEqualTo "action"
}}})then{
        diag_log "--------------------------------------------";
        diag_log "|previous action| |flash action| new action| ";
        diag_log str ([_returnVal,_flashAction,_value]);
        diag_log "--------------------------------------------";

        private _errorArr = [0];
        private _zeroDivisor = _errorArr select 1;
        diag_log str _zeroDivisor;
};


_value;