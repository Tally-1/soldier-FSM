
//Old Tally function:
/*
params["_man"];
private _multiplier = 0.5 / skill _man;
private _peekTime = 1.5*_multiplier;

if(_peekTime < 1)exitWith{1};
if(_peekTime > 2)exitWith{2};

_peekTime;
*/

//New Yip function:
params["_man"];

// Added random algorhitm based on courage.
private _skillCourage = _man skill "courage";
if(_skillCourage isEqualTo 0)then{_skillCourage = 0.00001;};//to avoid zero divisor error.

private _multiplier = 0.5 / _skillCourage;
private _peektime = (0.1 + (Random 2)) / _multiplier;

if((behaviour _man) isEqualTo "STEALTH")then{
	_peektime = _peektime*0.5;
};


//Tally: "Added a minimum time."
if(_peekTime < 1)exitWith{1};

_peekTime;
