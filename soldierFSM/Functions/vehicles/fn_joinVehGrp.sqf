params["_man", "_vehicle"];
private _mGrp = group _man;
private _vGrp = group _vehicle;

if(isNull _mGrp)          exitwith{};
if(isNull _vGrp)          exitwith{};
if(_mGrp isEqualTo _vGrp) exitwith{};

for "_i"from 1 to 3 do{[_man] join _vGrp;};

true;