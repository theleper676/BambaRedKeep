package;

import openfl.events.EventDispatcher;
import flash.display.*;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class BambaDungeonData extends EventDispatcher {
	public var anims:Array<Dynamic>;

	public var currDungeonDifficulty:Float;

	public var tiles:Array<Dynamic>;

	public var minLevel:Float;

	public var dDesc:String;

	public var dName:String;

	public var areaCode:Float;

	public var id:Float;

	public var uperTiles:Array<Dynamic>;

	public var difficultiesData:Array<Dynamic>;

	public var music:String;

	public var dungeonIconsGib:Array<Dynamic>;

	public var startTile:Float;

	public var enemiesIds:Array<Dynamic>;

	public var fightMusic:String;

	public var assetFileName:String;

	public var currEnemyId:Float;

	public var bossTile:Float;

	public function new(param1:Xml) {
		var _loc2_:Null<Dynamic> = null;
		var _loc3_:Null<Dynamic> = null;
		var _loc4_:Array<Dynamic> = null;
		var _loc5_:BambaDungeonTile = null;
		var _loc6_:Xml = null;
		var _loc7_:Xml = null;
		var _loc8_:Null<Dynamic> = null;
		var _loc9_:Null<Dynamic> = null;
		var _loc10_:Float = Math.NaN;
		var _loc11_:String = null;
		var _loc12_:Float = Math.NaN;
		var _loc13_:Float = Math.NaN;
		var _loc14_:Null<Dynamic> = null;
		var _loc15_:Null<Dynamic> = null;
		var _loc16_:Null<Dynamic> = null;
		var _loc17_:Null<Dynamic> = null;
		var _loc18_:Null<Dynamic> = null;
		var _loc19_:Null<Dynamic> = null;
		super();
      var uperTilesNode = param1.firstElement().elementsNamed("upertiles").next();
      var uperTilesString = uperTilesNode.firstChild().nodeValue;
      var tilesNode = param1.firstElement().elementsNamed("tiles").next();
      var tilesString = uperTilesNode.firstChild().nodeValue;
      
		id = Std.parseFloat(param1.get("id"));
		dName = param1.get("id");
		dDesc = param1.get("desc");
		areaCode = Std.parseFloat(param1.get("areaCode"));
      var uperTilesNode = param1.firstElement().elementsNamed("upertiles").next();
      var uperTilesString = uperTilesNode.firstChild().nodeValue;
      var tilesNode = param1.firstElement().elementsNamed("tiles").next();
      var tilesString = uperTilesNode.firstChild().nodeValue;
		uperTiles = uperTilesString.split(",");
		tiles = [];
		_loc4_ = tilesString.split("*");
		_loc2_ = 0;
		while (_loc2_ < _loc4_.length) {
			_loc8_ = _loc4_[_loc2_].split(":");
			_loc5_ = new BambaDungeonTile(_loc8_[0], _loc8_[1], _loc8_[2], _loc8_[3], _loc8_[4]);
			tiles.push(_loc5_);
			_loc3_ = 0;
			while (_loc3_ < uperTiles.length) {
				if (_loc5_.id == uperTiles[_loc3_]) {
					_loc5_.level = 2;
					break;
				}
				_loc3_++;
			}
			_loc2_++;
		}
		anims = [];
		for (_loc6_ in param1.anims.children()) {
			_loc9_ = [];
			_loc10_ = Std.parseFloat(_loc6_.tileId);
			_loc11_ = _loc6_.animName;
			_loc12_ = Std.parseFloat(_loc6_.babyHideFrame);
			_loc13_ = Std.parseFloat(_loc6_.babyShowFrame);
			_loc9_.push(_loc10_);
			_loc9_.push(_loc11_);
			_loc9_.push(_loc12_);
			_loc9_.push(_loc13_);
			anims.push(_loc9_);
		}
		startTile = param1.startTile;
		bossTile = param1.bossTile;
		assetFileName = param1.assetFileName;
		music = param1.music;
		fightMusic = param1.fightMusic;
		enemiesIds = param1.enemiesIds.split(",");
		difficultiesData = [];
		for (_loc7_ in param1.difficulties.children()) {
			_loc14_ = _loc7_.numOfEnemies;
			_loc15_ = _loc7_.numOfTreasures;
			_loc16_ = _loc7_.numOfSurprises;
			_loc17_ = _loc7_.possibleTreasuresPrizesIds.split(",");
			_loc18_ = _loc7_.possibleSurprisesIds.split(",");
			_loc19_ = [_loc14_, _loc15_, _loc16_, _loc17_, _loc18_];
			difficultiesData.push(_loc19_);
		}
		dungeonIconsGib = [];
		currEnemyId = 0;
		currDungeonDifficulty = 0;
	}

	public function saveDungeonIconsGib(param1:Array<Dynamic>, param2:Float, param3:Float):Dynamic {
		var _loc4_:Dynamic = undefined;
		dungeonIconsGib = [];
		_loc4_ = 0;
		while (_loc4_ < param1.length) {
			dungeonIconsGib.push(param1[_loc4_]);
			_loc4_++;
		}
		currEnemyId = param2;
		currDungeonDifficulty = param3;
	}

	function setMinLevel(param1:Dynamic):Dynamic {
		var _loc2_:Dynamic = undefined;
		minLevel = 100;
		_loc2_ = 0;
		while (_loc2_ < param1.length) {
			if (Number(param1[_loc2_][0]) == areaCode) {
				minLevel = Std.parseFloat(param1[_loc2_][1]);
			}
			_loc2_++;
		}
	}

	function getPossibleWays(param1:Dynamic, param2:Dynamic):Array<Dynamic> {
		var _loc3_:Array<Dynamic> = null;
		var _loc4_:Array<Dynamic> = null;
		var _loc5_:Array<Dynamic> = null;
		var _loc6_:Dynamic = undefined;
		var _loc7_:Dynamic = undefined;
		var _loc8_:Dynamic = undefined;
		var _loc9_:Dynamic = undefined;
		var _loc10_:Dynamic = undefined;
		var _loc11_:Dynamic = undefined;
		var _loc12_:Dynamic = undefined;
		var _loc13_:Dynamic = undefined;
		_loc3_ = [];
		_loc4_ = [];
		_loc5_ = [];
		_loc5_.push([param1, 0, param2, ""]);
		while (_loc5_.length > 0) {
			if (_loc5_[_loc5_.length - 1][2] == 0) {
				_loc3_.push(_loc5_[_loc5_.length - 1][0]);
				_loc4_.push(_loc5_[_loc5_.length - 1][3] + "," + _loc5_[_loc5_.length - 1][0]);
				_loc5_.pop();
			} else {
				_loc7_ = _loc5_[_loc5_.length - 1][0];
				_loc8_ = _loc5_[_loc5_.length - 1][1];
				_loc9_ = _loc5_[_loc5_.length - 1][2] - 1;
				if (_loc5_[_loc5_.length - 1][3] == "") {
					_loc10_ = _loc7_;
				} else {
					_loc10_ = _loc5_[_loc5_.length - 1][3] + "," + _loc7_;
				}
				_loc5_.pop();
				_loc11_ = getTile(_loc7_);
				_loc12_ = 0;
				while (_loc12_ < _loc11_.links.length) {
					if (_loc11_.links[_loc12_] != _loc8_) {
						_loc5_.push([_loc11_.links[_loc12_], _loc7_, _loc9_, _loc10_]);
					} else if (_loc11_.links.length == 1) {
						_loc5_.push([_loc11_.links[_loc12_], _loc7_, _loc9_, _loc10_]);
					}
					_loc12_++;
				}
			}
		}
		_loc6_ = 0;
		while (_loc6_ < _loc3_.length) {
			_loc13_ = _loc6_ + 1;
			while (_loc13_ < _loc3_.length) {
				if (_loc3_[_loc6_] == _loc3_[_loc13_]) {
					_loc3_.splice(_loc13_, 1);
					_loc4_.splice(_loc13_, 1);
					_loc13_--;
				}
				_loc13_++;
			}
			_loc6_++;
		}
		return _loc4_;
	}

	function drawDungeon(param1:MovieClip):Dynamic {
		var _loc2_:Int = 0;
		var _loc3_:Int = 0;
		var _loc4_:Int = 0;
		var _loc5_:Int = 0;
		var _loc6_:Dynamic = undefined;
		var _loc7_:Dynamic = undefined;
		var _loc8_:BambaDungeonTile = null;
		var _loc9_:BambaDungeonTile = null;
		var _loc10_:Shape = null;
		var _loc11_:Dynamic = undefined;
		var _loc12_:Dynamic = undefined;
		var _loc13_:Shape = null;
		var _loc14_:TextField = null;
		var _loc15_:TextFormat = null;
		_loc2_ = 16777215;
		_loc3_ = 16711680;
		_loc4_ = 2237183;
		_loc5_ = 1;
		_loc6_ = 4;
		_loc7_ = 0.5;
		_loc11_ = 0;
		while (_loc11_ < tiles.length) {
			_loc8_ = tiles[_loc11_];
			_loc12_ = 0;
			while (_loc12_ < _loc8_.links.length) {
				_loc9_ = getTile(_loc8_.links[_loc12_]);
				_loc10_ = new Shape();
				_loc10_.graphics.lineStyle(_loc6_, _loc3_, _loc7_);
				_loc10_.graphics.moveTo(_loc8_.x, _loc8_.y);
				_loc10_.graphics.lineTo(_loc9_.x, _loc9_.y);
				param1.addChild(_loc10_);
				_loc12_++;
			}
			_loc11_++;
		}
		_loc11_ = 0;
		while (_loc11_ < tiles.length) {
			_loc8_ = tiles[_loc11_];
			if (_loc8_.jump != 0) {
				_loc9_ = getTile(_loc8_.jump);
				_loc10_ = new Shape();
				_loc10_.graphics.lineStyle(_loc6_, _loc4_, _loc7_);
				_loc10_.graphics.moveTo(_loc8_.x, _loc8_.y);
				_loc10_.graphics.lineTo(_loc9_.x, _loc9_.y);
				param1.addChild(_loc10_);
			}
			_loc11_++;
		}
		_loc11_ = 0;
		while (_loc11_ < tiles.length) {
			_loc8_ = tiles[_loc11_];
			_loc13_ = new Shape();
			_loc13_.graphics.beginFill(_loc2_);
			_loc13_.graphics.lineStyle(_loc5_, _loc3_);
			_loc13_.graphics.drawCircle(_loc8_.x, _loc8_.y, 11);
			_loc13_.graphics.endFill();
			param1.addChild(_loc13_);
			(_loc14_ = new TextField()).autoSize = TextFieldAutoSize.CENTER;
			(_loc15_ = new TextFormat()).font = "Arial";
			_loc15_.color = 16711680;
			_loc15_.size = 10;
			_loc14_.defaultTextFormat = _loc15_;
			param1.addChild(_loc14_);
			_loc14_.x = _loc8_.x - 2;
			_loc14_.y = _loc8_.y - 8;
			_loc14_.text = Std.string(_loc8_.id);
			_loc11_++;
		}
	}

	function getTile(param1:Dynamic):Dynamic {
		var _loc2_:BambaDungeonTile = null;
		var _loc3_:Bool = false;
		var _loc4_:Dynamic = undefined;
		_loc3_ = false;
		_loc4_ = 0;
		while (_loc4_ < tiles.length) {
			if (tiles[_loc4_].id == param1) {
				_loc2_ = tiles[_loc4_];
				_loc3_ = true;
				break;
			}
			_loc4_++;
		}
		if (_loc3_) {
			return _loc2_;
		}
		trace("BambaDungeonData.getTile - Cant find tile no:" + param1);
		return null;
	}

	public function resetDungeon():Dynamic {
		dungeonIconsGib = [];
	}
}
