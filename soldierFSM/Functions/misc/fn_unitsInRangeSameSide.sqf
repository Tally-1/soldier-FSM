params["_man", "_unitArr", "_maxDistance"];
private _valids = _unitArr select {
	(_x distance2D _man < _maxDistance
	&&{(side _man)==(side _x)})
};
_valids;