package general;

import flash.text.TextField;

class Heb {
	public static var version:Float = 1;

	public function new() {}

	public static function reverseHeb(param1:Dynamic):String {
		var _loc2_:Dynamic = null;
		var _loc3_:Dynamic = null;
		var _loc4_:Dynamic = null;
		var _loc5_:Dynamic = null;
		_loc2_ = decodeString(param1);
		_loc3_ = "";
		_loc4_ = [];
		_loc5_ = 0;
		while (_loc5_ < param1.length) {
			if (_loc2_.charAt(_loc5_) == "H") {
				while (_loc4_.length > 0) {
					_loc3_ = _loc4_.pop() + _loc3_;
				}
				_loc3_ = param1.charAt(_loc5_) + _loc3_;
			} else {
				_loc4_.push(param1.charAt(_loc5_));
			}
			_loc5_++;
		}
		while (_loc4_.length > 0) {
			_loc3_ = _loc4_.pop() + _loc3_;
		}
		return _loc3_;
	}

	public static function setText(param1:TextField, param2:String):Void {
		var _loc3_:Dynamic = null;
		var _loc4_:Array<Dynamic> = null;
		var _loc5_:Dynamic = null;
		var _loc6_:Dynamic = null;
		var _loc7_:Dynamic = null;
		var _loc8_:Dynamic = null;
		var _loc9_:Dynamic = null;
		var _loc10_:Dynamic = null;
		param1.text = param2.charAt(0);
		_loc3_ = param1.textHeight;
		_loc4_ = [];
		_loc5_ = "";
		_loc6_ = 0;
		param1.text = "";
		_loc9_ = 0;
		while (_loc9_ < param2.length) {
			_loc8_ = false;
			if (param2.charAt(_loc9_) == " ") {
				_loc7_ = _loc9_;
			}
			switch (param2.charAt(_loc9_)) {
				case "(":
					param1.appendText(")");
					break;
				case ")":
					param1.appendText("(");
					break;
				case "\n":
					_loc8_ = true;
					break;
				default:
					param1.appendText(param2.charAt(_loc9_));
			}
			if (_loc3_ < param1.textHeight) {
				_loc8_ = true;
			}
			if (_loc8_) {
				_loc3_ = param1.textHeight;
				_loc5_ = param1.text.substring(_loc6_, _loc7_);
				_loc6_ = _loc7_ + 1;
				_loc4_.unshift(_loc5_);
			}
			_loc9_++;
		}
		_loc5_ = param1.text.substring(_loc6_, param2.length);
		_loc4_.unshift(_loc5_);
		_loc10_ = "";
		_loc9_ = 0;
		while (_loc9_ < _loc4_.length - 1) {
			_loc10_ = _loc10_ + _loc4_[_loc9_] + "\n";
			_loc9_++;
		}
		_loc10_ += _loc4_[_loc4_.length - 1];
		param1.text = reverseHeb(_loc10_);
	}

	public static function arangeLastFirstChars(param1:String):Dynamic {
		var _loc2_:Array<String> = null;
		var _loc3_:Array<Dynamic> = null;
		var _loc4_:Int = null;
		var _loc5_:Bool = null;
		var _loc6_:Int = null;
		_loc2_ = [];
		_loc3_ = [];
		_loc5_ = true;
		_loc6_ = 0;
		while (_loc6_ < param1.length) {
			_loc4_ = param1.charCodeAt(_loc6_);
			if (!(_loc4_ == 63 || _loc4_ == 33 || _loc4_ == 44 || _loc4_ == 58 || _loc4_ == 45 || _loc4_ == 39 || _loc4_ == 46)) {
				param1 = param1.substring(_loc6_, param1.length);
				_loc5_ = false;
				break;
			}
			_loc2_.push(param1.charAt(_loc6_));
			_loc6_++;
		}
		if (_loc5_) {
			param1 = "";
		}
		_loc6_ = param1.length - 1;
		while (_loc6_ > 0) {
			_loc4_ = param1.charCodeAt(_loc6_);
			if (!(_loc4_ == 63 || _loc4_ == 33 || _loc4_ == 44 || _loc4_ == 58 || _loc4_ == 45 || _loc4_ == 39 || _loc4_ == 46)) {
				param1 = param1.substring(0, _loc6_ + 1);
				break;
			}
			_loc3_.push(param1.charAt(_loc6_));
			_loc6_--;
		}
		_loc6_ = _loc2_.length;
		while (_loc6_ > 0) {
			param1 += _loc2_[_loc6_ - 1];
			_loc6_--;
		}
		_loc6_ = _loc3_.length;
		while (_loc6_ > 0) {
			param1 = _loc3_[_loc6_ - 1] + param1;
			_loc6_--;
		}
		return param1;
	}

	public static function decodeString(param1:String):String {
		var _loc2_:Dynamic = null;
		var _loc3_:Dynamic = null;
		var _loc4_:Dynamic = null;
		var _loc5_:Dynamic = null;
		var _loc6_:Dynamic = null;
		var _loc7_:Dynamic = null;
		var _loc8_:Dynamic = null;
		var _loc9_:Dynamic = null;
		var _loc10_:Dynamic = null;
		var _loc11_:Dynamic = null;
		_loc2_ = "H";
		_loc4_ = 0;
		while (_loc4_ < param1.length) {
			_loc3_ = param1.charCodeAt(_loc4_);
			if (_loc3_ >= 1424 && _loc3_ <= 1535) {
				_loc2_ += "H";
			} else if (_loc3_ == 32) {
				_loc2_ += "S";
			} else if (_loc3_ >= 65 && _loc3_ <= 90 || _loc3_ >= 97 && _loc3_ <= 122) {
				_loc2_ += "E";
			} else if (_loc3_ >= 48 && _loc3_ <= 57 || _loc3_ == 36 || _loc3_ == 8362 || _loc3_ == 45) {
				_loc2_ += "D";
			} else {
				_loc2_ += "N";
			}
			_loc4_++;
		}
		_loc2_ += "H";
		_loc5_ = "";
		_loc4_ = 0;
		while (_loc4_ < _loc2_.length) {
			_loc6_ = _loc2_.charAt(_loc4_);
			if (_loc6_ == "N" || _loc6_ == "S") {
				_loc7_ = _loc5_.charAt(_loc4_ - 1);
				if (_loc7_ == "H") {
					_loc5_ += "H";
				} else {
					_loc8_ = true;
					_loc9_ = 1;
					_loc10_ = false;
					while (_loc8_) {
						_loc11_ = _loc2_.charAt(_loc4_ + _loc9_);
						if (_loc11_ == "N" || _loc11_ == "S") {
							_loc9_++;
							if (_loc11_ == "S" || _loc6_ == "S") {
								_loc10_ = true;
							}
						} else {
							if (_loc11_ == "H") {
								_loc5_ += "H";
							} else if (_loc7_ == _loc11_) {
								if (_loc7_ == "D" && _loc10_) {
									_loc5_ += "H";
								} else {
									_loc5_ += _loc7_;
								}
							} else {
								_loc5_ += "H";
							}
							_loc8_ = false;
						}
					}
				}
			} else {
				_loc5_ += _loc2_.charAt(_loc4_);
			}
			_loc4_++;
		}
		return _loc5_.substr(1, _loc5_.length - 2);
	}
}
