// checks if a AZ-fipo is active for a particular side.
params["_side"];
private _fireZones       = (_self get "fire_zones")  select {_x call ["hostilePresent", [_side]]};
private _flankZones      = (_self get "flank_zones") select {_x call ["hostilePresent", [_side]]};

if(_fireZones  isEqualTo    []) exitWith{false;};
if(_flankZones isNotEqualTo []) exitWith{false;};

true;