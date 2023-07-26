params["_man", "_fipo"];
if!(side _man in (_fipo getVariable "allowedSides"))exitWith{false;};
true;