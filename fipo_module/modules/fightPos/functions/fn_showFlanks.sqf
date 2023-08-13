params["_fipo"];

if(typeOf _fipo isNotEqualTo "SFSM_FIPO")                         exitWith{false;};

if((_fipo getVariable ["showIndicators", false]) isEqualTo false) exitWith{false;};

if((_fipo getVariable ["rightFlank", -1]) < 1
&&{(_fipo getVariable ["leftFlank",  -1]) < 1
&&{_fipo getVariable "dynamicfipo" isEqualTo false}})             exitWith{false;};


true;