params["_side"];
if(_side isEqualTo west)       exitWith{[0,0,1,1]};
if(_side isEqualTo east)       exitWith{[1,0,0,1]};
if(_side isEqualTo independent)exitWith{[0,1,0,1]};

[1,1,1,0.8];