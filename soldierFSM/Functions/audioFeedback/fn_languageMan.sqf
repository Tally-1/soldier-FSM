params [
	["_man", nil, [objNull]]
];
private _lang = (speaker _man) select [6, 3];

if(_lang isEqualTo "eng") exitWith {"english";};
if(_lang isEqualTo "chi") exitWith {"chinese";};
if(_lang isEqualTo "rus") exitWith {"russian";};
if(_lang isEqualTo "pol") exitWith {"polish";};
if(_lang isEqualTo "per") exitWith {"persian";};
if(_lang isEqualTo "gre") exitWith {"greek";};
if(_lang isEqualTo "fre") exitWith {"french";};

"unknown";