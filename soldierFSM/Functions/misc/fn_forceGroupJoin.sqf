params["_man", "_group", "_index"];
private _keepJoining = true;
private _timer = time +1;

if(!isNil "_index")then{_man joinAsSilent [_group, _index];}
else{[_man] joinSilent _group};

while {_keepJoining} do {
	
	if(group _man isEqualTo _group) exitWith{_keepJoining = false;};
	if(_timer > time)               exitWith{_keepJoining = false;};

	if(!isNil "_index")then{_man joinAsSilent [_group, _index];}
    else{[_man] joinSilent _group};
};

true;