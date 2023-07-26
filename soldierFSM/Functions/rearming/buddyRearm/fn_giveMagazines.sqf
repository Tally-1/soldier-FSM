private _dropCount = 3;
params[
    "_giver",
    "_reciever",
    "_availableMags", 
    "_dropCount"
];
private _magCount = count _availableMags;
if(_magCount < _dropCount)then{_dropCount = _magCount;};

if(_dropCount < 1)exitWith{};

_giver disableAI "path";

for "_i" from 1 to _dropCount do{
    private _mag = _availableMags#0;
    _giver action ["dropMagazine", _reciever, _mag];
    hint (["Recieving mag ",_i, " of ", _dropCount, "..."]joinString"");
    sleep 2;
    _availableMags deleteAt 0;
};

_giver enableAI "path";

hint "Rearm completed";

true;