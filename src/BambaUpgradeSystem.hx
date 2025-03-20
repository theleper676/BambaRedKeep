package;

import flash.display.*;
import flash.events.MouseEvent;
import general.ButtonUpdater;
import general.Heb;
import general.MsgBox;
import general.PlayerDataUpdater;

class BambaUpgradeSystem {
	var cardsArray:Array<Dynamic>;

	var game:MovieClip;

	var mc:MovieClip;

	var currCardId:Float;

	public function new(param1:Dynamic) {
		super();
		game = param1;
		mc = BambaAssets.cardsUpgradeScreen();
		mc.orgWidth = mc.width;
		mc.orgHeight = mc.height;
		ButtonUpdater.setButton(mc.upgradeMC, upgradeClicked);
		ButtonUpdater.setButton(mc.exitMC, exitClicked);
		cardsArray = [];
		update();
	}

	function setCards():Dynamic {
		var _loc1_:Dynamic = undefined;
		var _loc2_:BambaCard = null;
		var _loc3_:Dynamic = undefined;
		var _loc4_:Dynamic = undefined;
		var _loc5_:Dynamic = undefined;
		currCardId = 0;
		cardsArray = [];
		_loc3_ = game.gameData.playerData.cards;
		_loc4_ = true;
		while (mc.cardsMC.numChildren > 0) {
			mc.cardsMC.removeChildAt(0);
		}
		_loc5_ = 0;
		_loc1_ = 0;
		while (_loc1_ < _loc3_.length) {
			_loc2_ = game.gameData.getNewCard(_loc3_[_loc1_]);
			if (_loc2_.upgradeTo != 0) {
				_loc2_.generateMC();
				_loc2_.mc.scaleX = 1;
				_loc2_.mc.scaleY = 1;
				mc.cardsMC.addChild(_loc2_.mc);
				_loc2_.mc.x = 225 - _loc5_ % 4 * 75;
				_loc2_.mc.y = Math.floor(_loc5_ / 4) * 105;
				_loc2_.setCardDir(-1);
				if (_loc2_.upgradeTo > 0) {
					_loc2_.mc.frontMC.gotoAndStop("reg");
					_loc2_.setCardforUpgrade(this);
					cardsArray.push(_loc2_);
				} else {
					_loc2_.mc.frontMC.gotoAndStop("disable");
				}
				_loc5_++;
			}
			_loc1_++;
		}
	}

	function update():Dynamic {
		PlayerDataUpdater.updateBasicData(mc.basicDataMC);
		PlayerDataUpdater.updateMoneyData(mc.moneyMC);
		PlayerDataUpdater.updateProgressData(mc.progressMC);
		mc.detailsMC.visible = false;
		setCards();
	}

	function upgradeClicked(param1:MouseEvent):Void {
		var _loc2_:BambaCard = null;
		var _loc3_:BambaCard = null;
		if (!game.msgShown) {
			game.sound.playEffect("GENERAL_MENU_CLICK");
			if (currCardId != 0) {
				_loc2_ = game.gameData.getCatalogCard(currCardId);
				if (_loc2_.upgradeTo == 0) {
					MsgBox.show(game.gameData.dictionary.UPGRADE_CANT_UPGRADE_CARD);
				} else {
					_loc3_ = game.gameData.getCatalogCard(_loc2_.upgradeTo);
					if (_loc3_.minLevel > game.gameData.playerData.level) {
						game.sound.playEffect("GENERAL_UNAVIALABLE");
						MsgBox.show(game.gameData.dictionary.UPGRADE_LEVEL_TO_LOW);
					} else if (game.gameData.playerData.ingredient1 >= _loc2_.ingredient1
						&& game.gameData.playerData.ingredient2 >= _loc2_.ingredient2
						&& game.gameData.playerData.ingredient3 >= _loc2_.ingredient3
						&& game.gameData.playerData.ingredient4 >= _loc2_.ingredient4) {
						game.help.showTutorial(23);
						game.help.finishTutorial();
						game.sound.playEffect("TOWER_MAGIC_UPGRADE");
						game.gameData.playerData.upgradeCard(_loc2_.id, _loc2_.upgradeTo);
						game.gameData.playerData.addIngredients(-_loc2_.ingredient1, -_loc2_.ingredient2, -_loc2_.ingredient3, -_loc2_.ingredient4);
						PlayerDataUpdater.updateMoneyData(mc.moneyMC);
						game.gameLoader.savePlayerData();
						setCards();
						clearDetails();
					} else {
						game.sound.playEffect("GENERAL_UNAVIALABLE");
						MsgBox.show(game.gameData.dictionary.UPGRADE_NO_INGREDIENTS);
					}
				}
			} else {
				MsgBox.show(game.gameData.dictionary.UPGRADE_MUST_PICK_ONE);
			}
		}
	}

	function cardRollOver(param1:Dynamic):Dynamic {
		var _loc2_:BambaCard = null;
		var _loc3_:BambaCard = null;
		_loc2_ = game.gameData.getCatalogCard(param1);
		if (_loc2_.upgradeTo != 0) {
			mc.detailsMC.visible = true;
			_loc3_ = game.gameData.getCatalogCard(_loc2_.upgradeTo);
			Heb.setText(mc.detailsMC.nameDT, _loc3_.cName);
			Heb.setText(mc.detailsMC.descDT, _loc2_.upgradeDesc);
			mc.detailsMC.minLevelDT.text = _loc3_.minLevel;
			mc.detailsMC.ingredient1DT.text = _loc2_.ingredient1;
			mc.detailsMC.ingredient2DT.text = _loc2_.ingredient2;
			mc.detailsMC.ingredient3DT.text = _loc2_.ingredient3;
			mc.detailsMC.ingredient4DT.text = _loc2_.ingredient4;
			while (mc.detailsMC.newCardMC.numChildren > 0) {
				mc.detailsMC.newCardMC.removeChildAt(0);
			}
			_loc3_.generateMC(-1);
			_loc3_.mc.gotoAndStop(1);
			mc.detailsMC.newCardMC.addChild(_loc3_.mc);
		} else {
			clearDetails();
		}
	}

	function clearDetails():Dynamic {
		mc.detailsMC.visible = false;
	}

	function cardClicked(param1:Dynamic):Dynamic {
		var _loc2_:Dynamic = undefined;
		_loc2_ = 0;
		while (_loc2_ < cardsArray.length) {
			cardsArray[_loc2_].mc.frontMC.gotoAndStop("reg");
			if (cardsArray[_loc2_].id == param1) {
				cardsArray[_loc2_].mc.frontMC.gotoAndStop("frame");
				currCardId = param1;
			}
			_loc2_++;
		}
	}

	function exitClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			game.sound.playEffect("GENERAL_MENU_CLICK");
			game.sound.stopLoopEffects();
			game.sound.playEffect("TOWER_BACK");
			game.hideUpgradeCrads();
		}
	}
}
