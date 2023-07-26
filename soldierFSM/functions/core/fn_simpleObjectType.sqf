params["_object"];
private _stringName = str _object;

// Old method
/*
private _letters = [];
private _nameLetter = false;


for "_i" from 0 to (count _stringName)-1
do{
    private _letter         = _stringName select [_i, 1];
    private _previousLetter = _stringName select [(_i -1), 1];
    private _next4          = _stringName select [_i, 4];
    
    if(_next4 == ".p3d")exitWith{};
    if(_nameLetter && {!(_letter == ".")}) then {_letters pushback _letter};

    if((!isNil "_previousLetter")
    &&{_previousLetter == ":"
    &&{_letter == " "}})
    then{_nameLetter = true};
};

private _name = _letters joinString "";
*/
// New method
// < "3374684b400# 122614: radar_f.p3d" > Split between : and . because name can't contain these -
// letters so the name is always in between

private _string = (((_stringName splitString ":") # 1) splitString ".") # 0;
if(isNil "_string")exitWith {""};
private _name = _string select [1, count _string]; // Get rid of the whitespace
if (isNil "_name") then {_name = ""};
_name
