params ["_man", "_endPos", "_timer"];
if(isNil "_man")exitWith{true};

if(isNil "_man")	exitWith{true};
if(!alive _man)		exitWith{true};
if(time > _timer)	exitWith{true};
if((_man distance2D _endPos) < (SFSM_DodgeDistance / 10))exitWith{true};

false