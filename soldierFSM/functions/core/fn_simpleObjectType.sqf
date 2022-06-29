params["_object"];
private _stringName = str _object;
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

_name