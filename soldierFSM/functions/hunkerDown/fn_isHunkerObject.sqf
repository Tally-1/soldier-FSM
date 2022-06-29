params ["_objData"];
private _objectShape = _objData get "3dData";
private _height      = (_objectShape get "top")#2;
private _xAndY       = [(_objectShape get "length"), (_objectShape get "width")];
private _XYratio     = (_objectShape get "Y to X");
private _maxSize     = (selectMax _xAndY);
private _minSize     = (selectMin _xAndY);

private _canCover    = _height > 0.35;
private _squareish   = _XYratio > 0.69 && {_XYratio < 1.4};
private _mediumSize  = _maxSize < 8 && {_minSize >= 0.7 && {_height < 4}};
private _notbush     = !((_objData get "type") in SFSM_treeTypes);

private _isHunkerObject = (
							_squareish 
							&& {_canCover 
							&& {_mediumSize 
							&& {_notbush}}}
						  );

_isHunkerObject