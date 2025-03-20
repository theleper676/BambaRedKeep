package general;

import flash.display.*;

class PlayerDataUpdater {
	static var game:Dynamic;

	public function new() {
	}

	public static function init(param1:Dynamic):Void {
		game = param1;
	}

	public static function updateMoneyData(param1:Dynamic):Void {
		param1.moneyDT.text = game.gameData.playerData.money;
		param1.ingredient1DT.text = game.gameData.playerData.ingredient1;
		param1.ingredient2DT.text = game.gameData.playerData.ingredient2;
		param1.ingredient3DT.text = game.gameData.playerData.ingredient3;
		param1.ingredient4DT.text = game.gameData.playerData.ingredient4;
	}

	public static function updateProgressData(param1:Dynamic):Void {
		var _loc2_:Dynamic = null;
		var _loc3_:Null<Int> = null;
		Heb.setText(param1.EXPOINTS, game.gameData.dictionary.EXPOINTS);
		Heb.setText(param1.exPointsDT, game.gameData.playerData.exPoints);
		_loc2_ = game.gameData.getCatalogPlayerLevel(game.gameData.playerData.level).nextLevelEx;
		Heb.setText(param1.NEXT_LEVEL, game.gameData.dictionary.NEXT_LEVEL);
		Heb.setText(param1.exPointsNextDT, _loc2_);
		if (game.gameData.playerData.level > 1) {
			_loc3_ = game.gameData.getCatalogPlayerLevel(game.gameData.playerData.level - 1).nextLevelEx;
		} else {
			_loc3_ = 0;
		}
		param1.xpBarMC.maskMC.width = 150 * (game.gameData.playerData.exPoints - _loc3_) / (_loc2_ - _loc3_);
		Heb.setText(param1.LIFE, game.gameData.dictionary.LIFE + " ");
		Heb.setText(param1.MAGIC, game.gameData.dictionary.MAGIC + " ");
		Heb.setText(param1.REGENERATION, game.gameData.dictionary.REGENERATION + " ");
		param1.lifeDT.text = game.gameData.playerData.maxLife;
		param1.magicDT.text = game.gameData.playerData.maxMagic;
		param1.regenerationDT.text = game.gameData.playerData.roundRegeneration;
	}

	public static function setBaby(param1:Dynamic, param2:Dynamic):Void {
		var _loc3_:Int = null;
		var _loc4_:Array<Dynamic> = [];
		var _loc5_:Null<Dynamic> = null;
		var _loc6_:BambaItem = null;
		var _loc7_:BambaItem = null;
		_loc4_ = ["hatMC", "capeMC", "beltMC", "shoesMC", "stickMC"];
		_loc3_ = 0;
		while (_loc3_ < _loc4_.length) {
			param1[_loc4_[_loc3_]].gotoAndStop("disable");
			while (param1[_loc4_[_loc3_]].itemMC.numChildren > 0) {
				param1[_loc4_[_loc3_]].itemMC.removeChildAt(0);
			}
			_loc3_++;
		}
		_loc5_ = game.gameData.playerData.itemsInUse;
		_loc3_ = 0;
		while (_loc3_ < _loc5_.length) {
			_loc6_ = game.gameData.getCatalogItem(_loc5_[_loc3_]);
			if (_loc6_ != null) {
				if (_loc6_.iType < 6) {
					_loc7_ = new BambaItem(_loc6_.xmlData);
					if (_loc6_ != null) {
						_loc6_.generateMC();
						_loc6_.addClickEventOnBaby(param2);
						param1[_loc4_[_loc6_.iType - 1]].itemMC.addChild(_loc6_.mc);
					}
				}
			}
			_loc3_++;
		}
	}

	public static function setItems(param1:Dynamic, param2:Dynamic, param3:Dynamic, param4:Dynamic):Void {
		var _loc5_:Int = null;
		var _loc6_:Dynamic = null;
		var _loc7_:Array<Dynamic> = null;
		var _loc8_:Dynamic = null;
		var _loc9_:Dynamic = null;
		var _loc10_:Float = null;
		var _loc11_:BambaItem = null;
		var _loc12_:MovieClip = null;
		_loc7_ = [];
		_loc7_ = _loc7_.concat(game.gameData.playerData.items);
		_loc8_ = game.gameData.playerData.itemsInUse;
		_loc5_ = 0;
		while (_loc5_ < _loc8_.length) {
			_loc6_ = 0;
			while (_loc6_ < _loc7_.length) {
				if (_loc7_[_loc6_] == _loc8_[_loc5_]) {
					_loc7_.splice(_loc6_, 1);
					break;
				}
				_loc6_++;
			}
			_loc5_++;
		}
		_loc7_.sort((a, b) -> a - b);
		while (param1.numChildren > 0) {
			param1.removeChildAt(0);
		}
		_loc9_ = 0;
		_loc5_ = 0;
		while (_loc5_ < _loc7_.length) {
			_loc11_ = new BambaItem(game.gameData.getCatalogItem(_loc7_[_loc5_]).xmlData);
			_loc11_.init(game);
			if (_loc11_ != null) {
				_loc11_.generateMC();
				param1.addChild(_loc11_.mc);
				_loc11_.mc.x = 152 + 9 - _loc9_ % 3 * 76;
				_loc11_.mc.y = 11 + Math.floor(_loc9_ / 3) * 52;
				_loc11_.addClickEvent(param3, _loc9_, param4);
				_loc9_++;
			}
			_loc5_++;
		}
		if (param4 == 2) {
			_loc10_ = 24;
		} else {
			_loc10_ = 27;
		}
		if (_loc9_ > _loc10_) {
			_loc12_ = new MovieClip();
			_loc12_.graphics.drawRect(9, 0, 1, 1);
			param1.addChild(_loc12_);
			_loc12_.y = Math.floor(_loc9_ / 3) * 52 + 20;
		}
		param2.source = param1;
		param2.refreshPane();
	}

	public static function updateBasicData(param1:Dynamic):Void {
		var _loc2_:Null<Dynamic> = null;
		Heb.setText(param1.CHARACTER_NAME, game.gameData.dictionary.CHARACTER_NAME + " ");
		Heb.setText(param1.CHARACTER_ORDER, game.gameData.dictionary.CHARACTER_ORDER + " ");
		Heb.setText(param1.CHARACTER_LEVEL, game.gameData.dictionary.CHARACTER_LEVEL + " ");
		Heb.setText(param1.nameDT, game.gameData.playerData.pName);
		_loc2_ = game.gameData.dictionary.ORDERS.split(",");
		Heb.setText(param1.orderDT, _loc2_[Std.parseInt(game.gameData.playerData.orderCode) - 1]);
		param1.levelDT.text = game.gameData.playerData.level;
	}
}
