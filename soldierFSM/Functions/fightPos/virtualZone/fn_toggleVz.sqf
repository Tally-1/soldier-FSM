if(_self call ["canDeActivate"]) exitWith{_self call ["deActivate"]};
if(_self call ["canActivate"])   exitWith{_self call ["activate"]};

false;