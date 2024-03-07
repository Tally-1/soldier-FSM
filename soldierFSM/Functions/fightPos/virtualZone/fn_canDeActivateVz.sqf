if!(_self get "active")            exitWith{false;};
if (_self call ["conditionsTrue"]) exitWith{false;};

true;