private _categorizedUnits  = [] call SFSM_fnc_woundedAndHealersGlobal;

// Data undefined? (battle may have ended)
if(isNil "_categorizedUnits")exitWith{};

private _medics           = _categorizedUnits#0;
private _fipoMedics       = _categorizedUnits#1;
private _healers          = _categorizedUnits#2;
private _availSpecialists = _categorizedUnits#3;
private _wounded          = _categorizedUnits#4;
private _incapacitated    = _categorizedUnits#5;

// Data corrupted? (battle may have ended)
if(isNil "_incapacitated")exitWith{};

private _maxHealCount = (count _medics) + (count _fipoMedics) + (count _healers) + (count _availSpecialists);

// if no healers were found then exit
if(_maxHealCount isEqualTo 0)exitWith{/*"Nobody is available for buddy-healing" call dbgmsg;*/};

// if no wounded or incapacitated units were found then exit
if(_wounded       isEqualTo []
&&{_incapacitated isEqualTo []})exitWith{};


// Debug message detaling the number of wounded and incapacitated units on the field
[[(count _wounded), " wounded and ", (count _incapacitated), " incapacitated on the field"]] call dbgmsg;
[[(count _healers), " healers available..."]] call dbgmsg;


// Assign medic to incapacitated units.
if(_incapacitated isNotEqualTo [])exitWith{
    [_categorizedUnits, _maxHealCount] spawn SFSM_fnc_battlefieldRevives; 
};


// Loop through all wounded units and assign a healer to them.
_medics append _healers;
private _excluded = [];
{
    private _woundedMan = [
        _x, 
        _wounded, 
        _incapacitated, 
        _excluded        

    ] call SFSM_fnc_initBuddyHeal;

    _excluded pushBackUnique _woundedMan;
    
} forEach _medics;

//end medical action.
true;