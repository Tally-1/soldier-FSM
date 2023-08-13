params[
	"_red",
	"_green",
	"_blue",
	["_alpha", 256],
	["_copy", false]
];

private _A3Red   = _red   / 256;
private _A3Green = _green / 256;
private _A3Blue  = _blue  / 256;
private _A3Alpha = _alpha / 256;

private _a3Color = [_A3Red, _A3Green, _A3Blue, _A3Alpha];

if(_copy)then{copyToClipboard str _a3Color;};

_a3Color;